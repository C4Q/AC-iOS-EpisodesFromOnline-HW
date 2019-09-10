//
//  EpisodesViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var show: Show!
    
    var episodes = [Episodes]() {
        didSet {
           
                self.episodeTableView.reloadData()
          
            
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.rowHeight = 200
        
    }
    
}

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodesTableViewCell
        
        let episode = episodes[indexPath.row]
        
        cell.nameLabel.text = episode.name
        cell.seasonAndNumberLabel.text = episode.seasonAndEpisode
        
        return cell
    }
    
    
}
