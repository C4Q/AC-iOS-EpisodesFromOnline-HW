//
//  EpisodeTableViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tvShowURL: String?
    
    var episodesBySeasonBrain = EpisodesBySeasonBrain()
    
    var episodesDict = [Int : [Int : Episode]]() {
        didSet {
            sectionKeys = episodesBySeasonBrain.getSeasonKeys(seasonsDict: episodesDict)
        }
    }
    
    var episodes = [Episode]() {
        didSet {
            episodesDict = episodesBySeasonBrain.makeSeasonsDict(episodes: episodes)
        }
    }
    
    var sectionKeys = [Int]() {
        didSet {
            episodeKeys = episodesBySeasonBrain.getEpisodeKeys(seasonsDict: episodesDict, seasonKeys: sectionKeys)
        }
    }
    
    var episodeKeys = [Int : [Int]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self; tableView.dataSource = self
        guard tvShowURL != nil else { return }
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedSeasonKey = sectionKeys[indexPath.section]
            let selectedEpisodeKey = episodeKeys[selectedSeasonKey]![indexPath.row]
            let selectedSeason = episodesDict[selectedSeasonKey]!
            let selectedEpisode = selectedSeason[selectedEpisodeKey]!
            destination.episode = selectedEpisode
        }
    }

}


