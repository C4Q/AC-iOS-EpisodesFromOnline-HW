//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showSelected: Shows!
    
    var id = ""

    var episodes = [Episodes]() { //Codable
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
    }
    

    func loadData() {
        id = showSelected.show.id.description
        let urlStr = "http:api.tvmaze.com/shows/\(id)/episodes"
        let setShowsToOnlineShows: ([Episodes]) -> Void = {(onlineEpisodes: [Episodes]) in
            self.episodes = onlineEpisodes
        }
        //FIX THIS IN API CLIENT
        EpisodesAPIClient.manager.getEpisodes(from: urlStr,
                                        completionHandler:setShowsToOnlineShows,
                                        errorHandler: {print($0)})
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
