//
//  TVShowsTableViewControllerExtensions.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

extension TVShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedShow = tvShows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVShowCell", for: indexPath) as? TVShowsTableViewCell else {
            return UITableViewCell()
        }
        cell.tvShowNameLabel.text = selectedShow.show.name
        cell.tvShowRatingLabel.text = "Rating: " + (selectedShow.show.rating?.average?.description ?? "Unavailable")
        cell.tvShowImageView.image = nil
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        guard let imageURL = selectedShow.show.image?.original else {
            cell.activityIndicator.isHidden = true
            cell.activityIndicator.stopAnimating()
            cell.tvShowImageView.image = #imageLiteral(resourceName: "Image-Coming-Soon-Placeholder")
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.tvShowImageView.image = onlineImage
            cell.setNeedsLayout()
            DispatchQueue.main.async {
                cell.activityIndicator.isHidden = true
                cell.activityIndicator.stopAnimating()
            }
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
}

extension TVShowsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text?.components(separatedBy: " ").joined(separator: "%20") ?? ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.components(separatedBy: " ").joined(separator: "%20")
        searchTerm = searchText
    }
    
    
}
