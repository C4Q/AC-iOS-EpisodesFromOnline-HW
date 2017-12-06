//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var showsSearchBar: UISearchBar!
    @IBOutlet weak var showsTableView: UITableView!
    
    var searchedShows = [Show]() {
        didSet {
            self.showsTableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsSearchBar.delegate = self
        self.showsTableView.delegate = self
        self.showsTableView.dataSource = self
    }
    
    func loadData() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))"
        let completion: ([Show]) -> Void = { (onlineShows: [Show]) in
            self.searchedShows = onlineShows
        }
        ShowAPIClient.manager.getShows(from: urlStr, completionHandler: completion, errorHandler: { print($0) })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowEpisodesViewController {
            guard let showsIndexPathSelected = self.showsTableView.indexPathForSelectedRow else { return }
            destination.showID = self.searchedShows[showsIndexPathSelected.row].show.id.description
        }
    }

}

extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showCell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath)
        let selectedShow = self.searchedShows[indexPath.row]
        if let showCell = showCell as? CustomShowTableViewCell {
            showCell.showSpinner.startAnimating()
            showCell.showSpinner.isHidden = false
            showCell.showNameLabel.text = selectedShow.show.name
            if let showRating = selectedShow.show.rating.average { showCell.showRatingLabel.text = showRating.description }
            else { showCell.showRatingLabel.text = "No Rating" }
            showCell.showImage.image = nil
            showCell.setNeedsLayout()
            var imageUrlStr: String
            if let showImage = selectedShow.show.image { imageUrlStr = showImage.medium }
            else {
                stopAndHideSpinner(cell: showCell)
                showCell.showImage.image = UIImage(named: "showImageNotFound")
                return showCell
            }
            let completion: (UIImage) -> Void = { (onlineShowImage: UIImage) in
                showCell.showImage.image = onlineShowImage
                showCell.setNeedsLayout()
                self.stopAndHideSpinner(cell: showCell)
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: { print($0) })
        }
        return showCell
    }
    
    func stopAndHideSpinner(cell: CustomShowTableViewCell) {
        cell.showSpinner.stopAnimating()
        cell.showSpinner.isHidden = true
    }
    
}

extension ShowsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        self.searchTerm = searchBarText
    }
    
}
