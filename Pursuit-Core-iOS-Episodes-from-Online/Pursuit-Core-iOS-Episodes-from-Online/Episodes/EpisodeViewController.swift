//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kevin Natera on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var episodes = [Episode]() {
        didSet {
            episodeTableOutlet.reloadData()
        }
    }
    
    @IBOutlet weak var episodeTableOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = episodeTableOutlet.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell {
            let episode = episodes[indexPath.row]
            cell.episodeNameLabel.text = episode.name
            cell.episodeNumberLabel.text = "Season \(episode.season), Episode \(episode.number)"
            
            if let url = episode.image?.medium {
                ImageHelper.shared.getImage(urlStr: url) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let image):
                            cell.episodeImageOutlet.image = image
                        }
                    }
                }
            } else {
                cell.episodeImageOutlet.image = UIImage(named: "noImage")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailEpisodeVC = segue.destination as? EpisodeDetailViewController else { fatalError() }
        detailEpisodeVC.episode = episodes[episodeTableOutlet.indexPathForSelectedRow!.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
    }
    
    private func setUpProtocols() {
        episodeTableOutlet.delegate = self
        episodeTableOutlet.dataSource = self
        episodeTableOutlet.rowHeight = 150
    }

}
