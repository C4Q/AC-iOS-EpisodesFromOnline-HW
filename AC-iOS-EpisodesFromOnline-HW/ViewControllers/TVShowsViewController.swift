//
//  TVShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tvShowTableView: UITableView!
    
    //MARK: - Variables
    var tvShows = [TVShows](){
        didSet {
            tvShowTableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet  {
            loadData()
            tvShowTableView.reloadData()
        }
    }

    //MARK: - ViewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tvShowTableView.delegate = self
        tvShowTableView.dataSource = self
        loadData()
    }

    //MARK: - Functions
    func loadData() {
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([TVShows]) -> Void = { (onlineShows: [TVShows]) in
            self.tvShows = onlineShows
        }
        TVShowAPIClient.manager.getTVShows(from: url, completionHandler: completion, errorHandler: { print($0) })
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let selectedShow = tvShows[(tvShowTableView.indexPathForSelectedRow?.row)!].show.id
            destination.episodesURL = "http://api.tvmaze.com/shows/\(selectedShow)/episodes"
        }
    }

}


