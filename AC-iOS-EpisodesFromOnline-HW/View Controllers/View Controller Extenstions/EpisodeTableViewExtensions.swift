//
//  EpisodeTableViewExtensions.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

extension EpisodeTableViewController {
    
    func loadData() {
        guard let tvShowURL = tvShowURL else { return }
        let completion: ([Episode]) -> Void = { (onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        EpisodeAPIClient.manager.getTVShows(from: tvShowURL, completionHandler: completion, errorHandler: { print($0) })
    }
    
}

extension EpisodeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episodes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let selectedEpisode = episodes[indexPath.row]
        
        if let cell = cell as? EpisodeTableViewCell {
            cell.episodeTitleLabel.text = selectedEpisode.name
            let season = selectedEpisode.season?.description ?? "N/A"
            let number = selectedEpisode.number?.description ?? "N/A"
            cell.episodeSeasonLabel.text = "Season: \(season) Episode: \(number)"
            cell.episodeImageView.image = nil
            
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            
            if let imageURL = selectedEpisode.image?.medium {
                let completion: (UIImage?) -> Void = { (onlineImage: UIImage?) in
                    cell.episodeImageView.image = onlineImage
                    cell.setNeedsLayout()
                    DispatchQueue.main.async {
                        cell.spinner.isHidden = true
                        cell.spinner.stopAnimating()
                    }
                }
                ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: { print($0) })
                
            } else {
                cell.spinner.isHidden = true
                cell.spinner.stopAnimating()
                cell.episodeImageView.image = #imageLiteral(resourceName: "no-image-icon")
                
            }
            
        }
        return cell
    }
    
}
