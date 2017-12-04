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
    
    var episodesDict = [Int : [Int : Episode]]() {
        didSet {
            sectionKeys = episodesDict.keys.sorted()
        }
    }
    
    var episodes = [Episode]() {
        didSet {
            episodesDict = EpisodesBySeasonBrain().makeSeasonsDict(episodes: episodes)
        }
    }
    
    var sectionKeys = [Int]() {
        didSet {
            print(sectionKeys)
            var nestedKeyDict = [Int : [Int]]()
            for i in 0..<sectionKeys.count {
                let array = episodesDict[sectionKeys[i]]?.keys.sorted()
                nestedKeyDict[sectionKeys[i]] = array
            }
            episodeKeys = nestedKeyDict
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
            let selectedEpisode = episodes[(tableView.indexPathForSelectedRow?.row)!]
            destination.episode = selectedEpisode
        }
    }

}


