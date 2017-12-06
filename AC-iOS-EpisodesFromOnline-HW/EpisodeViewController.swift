//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var showInst: Show!

    var show: Show! {
        didSet {
            loadEpisode()
        }
    }
    
    var episodes = [Episode]() {
        didSet {
            self.episodeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = show.name
        episodeTableView.dataSource = self
    }
    
    func loadEpisode() {
        let urlStr = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr,
                                             completionHandler: completion,
                                             errorHandler: {print($0)})
    }
}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "Show Detail Cell", for: indexPath)
        let episode = episodes[indexPath.row]
        cell.detailTextLabel?.text = "\(episode.season != nil && episode.number != nil ? "S: \(episode.season!) E: \(episode.number!) " : "Air date unavailable")"
        cell.textLabel?.text = "\((!(episode.name?.contains("Episode "))!) ? "\(episode.name!)" : "Not yet aired")"
        tableView.rowHeight = 80
        cell.textLabel?.numberOfLines = 3
        
        guard let imageUrlStr = episode.image?.medium else {
            cell.imageView?.image = #imageLiteral(resourceName: "noImage")
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHander: completion,
                                        errorHander: {print($0)})
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            destination.episodes = episodes[episodeTableView.indexPathForSelectedRow!.row]
        }
    }
}
