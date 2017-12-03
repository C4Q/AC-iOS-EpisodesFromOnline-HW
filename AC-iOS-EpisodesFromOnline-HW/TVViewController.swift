//
//  TVViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TVViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var TVTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tvShows = [TVShows]() {
        didSet {
            self.TVTableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TVTableView.delegate = self
        self.TVTableView.dataSource = self
        self.searchBar.delegate = self
        //loadData()
    }
    
    func loadData() {
    //API goes here
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([TVShows]) -> Void = {(onlineTVShow: [TVShows]) in
            self.tvShows = onlineTVShow
        }
        TVAPIClient.manager.getTVShows(from: url, completionHandler: completion , errorHandler: {print($0)})
        
    }
    //SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? "" //Prevents nils
        searchBar.resignFirstResponder()
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = TVTableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as? TVTableViewCell else {return UITableViewCell()}
        let tvSeries = tvShows[indexPath.row]
        
                cell.tvNameLabel.text = "Name: \(tvSeries.show.name)"
                cell.tvRatingLabel.text = "Rating: \(tvSeries.show.rating)"
                cell.tvImageView.image = nil
        
        //PUT IMAGE API HERE
        
        let urlStr = tvSeries.show.image.medium
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.tvImageView.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: urlStr,
                                         completionHandler: setImageToOnlineImage,
                                         errorHandler: {print($0)})

        return cell
    }
    

}
