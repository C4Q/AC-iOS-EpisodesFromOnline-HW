//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var show: Show?
    
    var episodes = [Episode](){
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewEpisodes()
        self.tableView.dataSource = self
    }
    
    func loadNewEpisodes() {
        
        guard let show = show else {return}
        let urlStr = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        let errorHandler: (Error) -> Void = {print($0)}
        
        EpisodeAndSeasonAPI.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            let selectedEpisode = episodes[(tableView.indexPathForSelectedRow?.row)!]
            destination.episode = selectedEpisode
        }
        
    }
}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath)
        
        
        if let cell = cell as? EpisodeTableViewCell {
            
            let episode = episodes[indexPath.row]
            cell.episodeName.text = episode.name
            cell.episodeNumberAndSeason.text = "E: \(episode.number.description)   S: \(episode.season.description)"
            cell.episodeImage.image = nil
            if episode.image == nil {
                cell.imageView?.image = #imageLiteral(resourceName: "notAvailableimage")
            }
            else {
                let imageUrlStr = episode.image?.medium
                let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                    cell.imageView?.image = onlineImage
                    cell.setNeedsLayout()
                    //MAKES THE IMAGE LOAD AS SOON AS ITS READY
                    
                }
                ImageAPIClient.manager.getImage(from: imageUrlStr!, completionHandler: completion, errorHandler: {print($0)})
            }
            
        }
        return cell
    }
    
    
}
