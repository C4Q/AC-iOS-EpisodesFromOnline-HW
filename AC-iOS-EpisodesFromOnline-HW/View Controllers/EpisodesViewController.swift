//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var show: Show! {
        didSet {
            loadEpisodes()
        }
    }
    var episodes = [Episode]() {
        didSet {
            self.episodesFiltered = self.episodes
        }
    }
    var episodesFiltered = [Episode]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            if searchTerm.count > 0 {
                self.episodesFiltered = self.episodes.filter{$0.name.lowercased().contains(searchTerm.lowercased())}
            } else {
                self.episodesFiltered = self.episodes
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodeTableView.delegate = self
        self.episodeTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    func loadEpisodes() {
        let str = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        EpisodesAPIClient.manager.getEpisodes(from: str, completionHandler: completion, errorHandler: errorHandler)
    }

}
