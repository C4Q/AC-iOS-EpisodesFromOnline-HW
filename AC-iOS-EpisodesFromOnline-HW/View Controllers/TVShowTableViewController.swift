//
//  TVShowTableViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TVShowTableViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var shows = [TVShow]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self; tableView.dataSource = self
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeTableViewController {
            let selectedShow = shows[(tableView.indexPathForSelectedRow?.row)!]
            let showId = selectedShow.show.id
            destination.tvShowURL = "http://api.tvmaze.com/shows/\(showId)/episodes"
        }
    }

}
