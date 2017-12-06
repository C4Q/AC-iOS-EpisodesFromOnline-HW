//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Keshawn Swanston on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    var show: Show! {
        didSet {
            loadEpisodes()
        }
    }
    var episodes = [Episode](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    func loadEpisodes() {
        let urlStr = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
}

extension EpisodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = "S:\(episode.season) E:\(episode.number)"
        if let imageStr = episode.image {
            let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.imageView?.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageStr.medium, completionHandler: setImage, errorHandler: {print($0)})
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "noImage")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDVC = segue.destination as? DetailViewController {
            destinationDVC.episode = episodes[self.tableView.indexPathForSelectedRow!.row]
        }
    }
}
