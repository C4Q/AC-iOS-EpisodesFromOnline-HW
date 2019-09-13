//
//  SingleShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SingleShowViewController: UIViewController {
    
    var showId = Int() {
        didSet {
            loadEpisodesData()
        }
    }
    
    var showEpisodes = [Episodes]() {
        didSet {
            SingleShowTableView.reloadData()
        }
    }

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var SingleShowTableView: UITableView!
    
    override func viewDidLoad() {
        SingleShowTableView.dataSource = self
        SingleShowTableView.delegate = self 
        super.viewDidLoad()

    }
    
    private func loadEpisodesData() {
        let url = "https://api.tvmaze.com/shows/\(showId)/episodes"
        
        ShowAPIHelper.shared.getEpisodes(url: url) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodesFromServer):
                    self.showEpisodes = episodesFromServer
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }

}

extension SingleShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SingleShowTableView.dequeueReusableCell(withIdentifier: "EpisodesListTVC")
        let episode = showEpisodes[indexPath.row]
        cell?.textLabel?.text = episode.name
        cell?.detailTextLabel?.text = "S\(episode.season): E\(episode.number)"
        
        if episode.image != nil {
            ImageHelper.getImage(stringUrl: episode.image!.medium) { (error, image) in
                if let image = image {
                    DispatchQueue.main.async {
                        cell?.imageView?.image = image
                    }
                    
                }
            }
        }
        
        return cell!
    }
    
    
}

extension SingleShowViewController: UITableViewDelegate {
    
}
