//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    
    
    var shows = [Show]()
    
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    /// http://api.tvmaze.com/search/shows?q=\(searchTerm)
    /// load the SHOWS into the tableView that fall into the searchTerm
    /// searchTerm criteria will change the loading of the results.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
    }
}

extension ShowsViewController: UISearchBarDelegate {
    
    var filteredSearch: [Show] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return shows
        }
        return shows.filter{(show) in
            show.show.name.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text?.lowercased()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    
}


extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSearch.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = filteredSearch[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath)
        cell.textLabel?.text = show.show.name
        cell.detailTextLabel?.text = "Rating: \(show.show.rating.average)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            let selectedShow = self.filteredSearch[selectedRow] /// filtered search or original shows array?
            destination. // to do
        }
    }
    
    
}











