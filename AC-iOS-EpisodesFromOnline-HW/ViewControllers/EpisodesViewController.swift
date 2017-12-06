//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    
    //MARK: - Variables
    var episodesURL: String?
    var episodes = [Episode]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    //MARK: - viewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        loadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            let selectedEpisode = episodes[(episodeTableView.indexPathForSelectedRow?.row)!]
            destination.selectedEpisode = selectedEpisode
        }
    }
    
    //MARK: - Functions
    func loadData() {
        guard let episodesURL = episodesURL else { return }
        EpisodeAPIClient.manager.getEpisodes(from: episodesURL, completionHandler: {self.episodes = $0}, errorHandler: { print($0) })
    }
    
    
}




