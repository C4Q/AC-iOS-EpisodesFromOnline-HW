//
//  EpisodesTableViewControllerExtensions.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = episodes.isEmpty ? 1 : episodes.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        if let cell = cell as? EpisodeTableViewCell {
            guard !episodes.isEmpty else {
                cell.episodeNameLabel.text = ""
                cell.episodeIndexLabel.text = ""
                return cell
            }
            let episode = episodes[indexPath.row]
            cell.episodeNameLabel.text = episode.name
            cell.episodeIndexLabel.text = "S:" + (episode.season?.description ?? "N/A") + " E:" + (episode.number?.description ?? "N/A")
            cell.episodeImageView.image = nil
            cell.activityIndicator.startAnimating()
            guard let imageURL = episode.image?.original else { cell.episodeImageView.image = #imageLiteral(resourceName: "Image-Coming-Soon-Placeholder"); cell.activityIndicator.stopAnimating(); return cell }
            let imageUrlStr = imageURL
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.episodeImageView.image = onlineImage
                cell.setNeedsLayout()
                cell.activityIndicator.stopAnimating()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        }
        return cell
    }

}
