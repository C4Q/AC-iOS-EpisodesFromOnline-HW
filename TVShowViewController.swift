//
//  TVShowViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TVShowViewController: UIViewController {
    
    var shows = [Show]() {
        didSet {
            self.tableView.reloadData()
        }
       
    }
  
    var searchTerm = "" {
        didSet {
            loadNewShows()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
         loadNewShows()
        
    }
    
    func loadNewShows() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(self.searchTerm)"
        let completion: ([Show]) -> Void = {(onlinShows: [Show]) in
            self.shows = onlinShows
        }
        let errorHandler: (AppError) -> Void = {(error: AppError) in ()}
//
    
        TVShowAPIClient.manager.getTVShows(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? EpisodeViewController {
        let selectedShow = shows[(tableView.indexPathForSelectedRow?.row)!]
         destination.show = selectedShow
        }
    }
}

extension TVShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVShow Cell", for: indexPath) as! TableViewCell
        let show = shows[indexPath.row]
        cell.tvShowName.text = show.name
        cell.tvShowRating.text = show.rating?.average?.description
        cell.tableImageView.image = nil
        guard let imageUrlStr = show.image?.medium else {
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
}

extension TVShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
    
    
}
