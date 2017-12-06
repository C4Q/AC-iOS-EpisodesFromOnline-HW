//
//  ShowsTableViewController.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ShowsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            loadShows()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        loadShows()
    }
    
    func loadShows() {
        var urlStr = ""
        if searchTerm == "" {
            urlStr = "http://api.tvmaze.com/shows"
        } else {
            urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        }
        let setShowsToOnlineShows = {(onlineShows: [Show]) in
            self.shows = onlineShows
        }
        ShowAPIClient.manager.getShows(from: urlStr, completionHandler: setShowsToOnlineShows, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Episodes Segue" else { print("1");return}
        guard let cell = sender as? ShowTableViewCell else { print("2");return}
        guard let episodesTableViewCell = segue.destination as? EpisodesTableViewController else { print("3");return}
        guard let index = tableView.indexPath(for: cell)?.row else { print("4");return}
        episodesTableViewCell.selectedShowId = shows[index].id
        print(shows[index].id)
    }
}

extension ShowsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as! ShowTableViewCell
        let show = shows[indexPath.row]
        cell.nameLabel?.text = show.name
        cell.ratingLabel.text = String(show.rating?.average ?? 0)
        cell.coverImageView.image = nil
        cell.showSpinner.isHidden = false
        cell.showSpinner.startAnimating()
        if let urlStr = show.image?.medium {
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.coverImageView.image = onlineImage
                cell.showSpinner.isHidden = true
                cell.showSpinner.stopAnimating()
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageToOnlineImage, errorHandler: {print($0)})
        } else {
            cell.coverImageView.image = #imageLiteral(resourceName: "NoImg")
            cell.showSpinner.isHidden = true
            cell.showSpinner.stopAnimating()
        }
        return cell
    }
}

extension ShowsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
}
