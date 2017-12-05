//
//  TVShowTableViewExtensions.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

// MARK: - Helper Functions

extension TVShowTableViewController {
    
    func loadData() {
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([TVShow]) -> Void = { (onlineShows: [TVShow]) in
            self.shows = onlineShows
        }
        TVShowAPIClient.manager.getTVShows(from: url, completionHandler: completion, errorHandler: { print($0) })
    }
    
}

// MARK: - Search Bar

extension TVShowTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text?.components(separatedBy: " ").joined(separator: "%20") ?? ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.components(separatedBy: " ").joined(separator: "%20")
        searchTerm = searchText
    }
    
}

// MARK: - Table View

extension TVShowTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Television Shows"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath)
        let selectedShow = shows[indexPath.row]
        
        if let cell = cell as? TVShowTableViewCell {
            cell.spinner.activityIndicatorViewStyle = .whiteLarge
            cell.showTitleLabel.text = selectedShow.show.name
            cell.showRatingLabel.text = "Rating: " + (selectedShow.show.rating?.average?.description ?? "Not Available")
            cell.showImageView.image = nil
            
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            
            if let imageURL = selectedShow.show.image?.medium {
                let completion: (UIImage?) -> Void = { (onlineImage: UIImage?) in
                    cell.showImageView.image = onlineImage
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
                cell.showImageView.image = #imageLiteral(resourceName: "no-image-icon")
            }
        }
        return cell
    }
    
}
