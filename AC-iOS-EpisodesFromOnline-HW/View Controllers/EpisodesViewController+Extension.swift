//
//  EpisodesViewController+Extension.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit
extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodesFiltered.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodesFiltered[indexPath.row]
        if let cell = episodeTableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as? EpisodesTableViewCell {
            cell.nameEpisodeLabel.text = episode.name
            cell.seasonEpisodeLabel.text = "S:\(episode.season) || E:\(episode.number)"
            if let image = episode.image, let urlImage = image.medium {
                let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                    cell.episodeImageView.image = onlineImage
                    cell.setNeedsLayout() //Makes the image load as soon as it's ready
                }
                let errorHandler: (Error) -> Void = {(error: Error) in
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                ImageAPIClient.manager.getImage(from: urlImage,
                                                completionHandler: completion,
                                                errorHandler: errorHandler)
            } else {
                cell.episodeImageView.image = #imageLiteral(resourceName: "noimage")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let episodeDet = episodes[episodeTableView.indexPathForSelectedRow!.row]
        if let episodeDVC = segue.destination as? EpisodeDetailViewController {
            episodeDVC.episodeDetail = episodeDet
        }
    }
    
}
