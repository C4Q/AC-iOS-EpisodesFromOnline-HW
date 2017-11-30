//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
        episodeTableView.dataSource = self
        }
    }
    
    var episodeEndpoint: String! {
        didSet {
            print(episodeEndpoint)
            EpisodeAPIClient.manager.getEpisodes(from: episodeEndpoint,
                                                 completionHandler: {self.episodes = $0},
                                                 errorHandler: {print($0)})
        }
    }
    
    var episodes: [Episode]? {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(episodeEndpoint)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: Table View Data Source
extension EpisodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let index = indexPath.row
        guard let currentEpisode = episodes?[index] else { return cell }
        cell.textLabel?.text = currentEpisode.name
        cell.detailTextLabel?.text = "Season: \(currentEpisode.season) Number: \(currentEpisode.number)"
        
        // MARK: - Downloads images async
        if let albumURL = URL(string: currentEpisode.image?.medium ?? "noImage") {
            
            // doing work on a background thread
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: albumURL) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                } else {
                    cell.imageView?.image = UIImage(named: "noImage")
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
}
