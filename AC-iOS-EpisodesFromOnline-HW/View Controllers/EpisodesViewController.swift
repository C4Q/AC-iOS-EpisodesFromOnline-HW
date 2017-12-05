//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    let show: Show? = nil
    var episodes = [Episode]()
    
    ///  http://api.tvmaze.com/singlesearch/shows?q=\(show.show.name.lowercased())&embed=episodes
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesTableView.dataSource = self
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    


}
