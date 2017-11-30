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
    
    var episodes = [Episode]() {
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


