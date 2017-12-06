//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var shows = [ShowResults]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        searchBar.delegate = self
    }
    func loadData() {
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
            ShowAPIClient.manager.getShows(from: url, completionHandler: {self.shows = $0}, errorHandler: {print($0)})
        
    }
    
    
    ///http://api.tvmaze.com/shows/\(showid)&embed=episodes
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let showID = shows[(tableView.indexPathForSelectedRow?.row)!].show.id
            destination.episodeURL = "http://api.tvmaze.com/shows/\(showID)/episodes"
        }
        //            if let destination = segue.destination as? EpisodeDetailViewController {
        //                let selectedRow = self.episodesTableView.indexPathForSelectedRow!.row
        //                let selectedEpisode = self.episodes[selectedRow] /// filtered search or original shows array?
        //                destination.episode = selectedEpisode
    }
}


extension ShowsViewController: UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let show = shows[indexPath.row]
        
        guard let showCell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as? CustomShowCell else {return UITableViewCell() }
        showCell.showNameLabel.text = show.show.name
        showCell.showRatingLabel.text = show.show.rating?.average?.description ?? "No Rating Available"
        guard let imageUrlStr = show.show.image?.medium else {return showCell}
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            showCell.showImageView?.image = onlineImage
            showCell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return showCell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text!
        searchBar.resignFirstResponder()
    }
}
