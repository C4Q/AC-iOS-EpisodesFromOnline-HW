//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showsTableView: UITableView!
    
    
    var shows = [Shows]() {
        didSet {
            showsTableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            if searchTerm.count > 0 {
                loadShows(from: searchTerm)
            } else {
                shows = []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsTableView.delegate = self
        self.showsTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    func loadShows(from filter: String) {
        let filterStr = filter.replacingOccurrences(of: " ", with: "+")
        let str = "http://api.tvmaze.com/search/shows?q=\(filterStr)"
        let completion: ([Shows]) -> Void = {(onlineShows: [Shows]) in
            self.shows = onlineShows
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        ShowsAPIClient.manager.getShows(from: str, completionHandler: completion, errorHandler: errorHandler)
    }

}

