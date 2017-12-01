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
    
    var searchedShows = [Show]()
    
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
        let completion: ([Show]) -> Void = {(onlineShows: [Show]) in
            self.searchedShows = onlineShows
            self.showsTableView.reloadData()
        }
        ShowAPIClient.manager.getShows(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowEpisodesViewController {
            destination.showID = self.searchedShows[(self.showsTableView.indexPathForSelectedRow?.row)!].show.id.description
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
            showCell.showNameLabel.text = selectedShow.show.name
            showCell.showRatingLabel.text = selectedShow.show.rating.average?.description ?? "No Rating"
            //showCell.showImage.image = nil
            showCell.showImage.image = UIImage(named: "showimageNF")
            guard let imageUrlStr = selectedShow.show.image?.medium else { return showCell }
            let completion: (UIImage) -> Void = {(onlineShowImage: UIImage) in
                showCell.showImage.image = onlineShowImage
                showCell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        }
        return showCell
    }
    
}

extension ShowsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchBar.text!
    }
    
}
