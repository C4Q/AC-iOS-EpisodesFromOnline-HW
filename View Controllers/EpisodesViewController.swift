//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var episodes = [Episode]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var showInst: Show!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData() {
        let urlStr = "http://api.tvmaze.com/\(showInst.show.id)/1/episodes"
        let setShowToEpisodes: (Episode) -> Void = {(setShowToEpisodes) in
            self.episodes = [setShowToEpisodes]
            
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: setShowToEpisodes, ErrorHandler: {print($0)})
    }


}
extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode cell", for: indexPath)
        cell.textLabel?.text = episode.name
        return cell
    }
}
