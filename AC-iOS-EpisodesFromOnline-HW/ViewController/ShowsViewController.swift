//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var shows = [ShowInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            loadShows()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.delegate = self; tableView.dataSource = self
        searchBar.delegate = self
        loadShows()
    }
    func loadShows() {
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        ShowAPIClient.manager.getShows(from: url, completionHandler: {self.shows = $0}, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let showID = shows[tableView.indexPathForSelectedRow!.row].show.id
            destination.episodeURL = "http://api.tvmaze.com/shows/\(showID)/episodes"
        }
    }
}

extension ShowsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    ///Mark - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        guard let showCell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowTableViewCell else {
            return UITableViewCell()
        }
        showCell.nameLabel.text = show.show.name
        showCell.rateLabel.text = "Rating: \(show.show.rating.average?.description ?? "N/A")"
        showCell.showImageView.image = nil
                showCell.showSpinner.isHidden = false
                showCell.showSpinner.startAnimating()
        guard let imageURL = show.show.image?.original else {
            showCell.showSpinner.isHidden = true
            showCell.showSpinner.stopAnimating()
            showCell.showImageView.image = #imageLiteral(resourceName: "noImage")
            return showCell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            showCell.showImageView.image = onlineImage
            showCell.setNeedsLayout()
            DispatchQueue.main.async {
                showCell.showSpinner.isHidden = true
                showCell.showSpinner.stopAnimating()
            }
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
        return showCell
    }
    
    ///Mark - Search Bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
        searchBar.resignFirstResponder()
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.searchTerm = searchText.components(separatedBy: " ").joined(separator: "%20")
//    }
    
}

