//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {

    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var myShow: ShowWrapper! {
        didSet {
            loadEpisodes()
        }
    }
    
    var episodes = [Episode]() {
        didSet {
            self.episodeTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.dataSource = self
        

    }
    
    func loadEpisodes() {
        let urlStr = "http://api.tvmaze.com/shows/\(myShow.show.id)/episodes"
        EpisodesAPIClient.shared.getShows(from: urlStr, completionHandler: {self.episodes = $0}, errorHandler: {print($0)})
    }

}
extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.episodeTableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as? EpisodeTableViewCell else {return UITableViewCell()}
        let thisEpisode = self.episodes[indexPath.row]
        cell.nameLabel.text = thisEpisode.name
        cell.seasonEpisodeLabel.text? = "Season \(thisEpisode.season ?? 0)"
        cell.episodeLabel.text? = "Episode \(thisEpisode.number ?? 0)"
        
        
        
        if let imageUrl = thisEpisode.image?.medium {
        let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.episodeImageView.image = onlineImage
            cell.setNeedsLayout()
            }
              ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: getImage, errorHandler: {print($0)})
        } else {
            cell.episodeImageView.image = #imageLiteral(resourceName: "noImage")
        }
      
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDVC = segue.destination as? EpisodeDetailViewController {
            let selectedRow = episodeTableView.indexPathForSelectedRow?.row
            let selectedEpisode = episodes[selectedRow!]
            destinationDVC.anEpisode = selectedEpisode
        }
    }
    
}







