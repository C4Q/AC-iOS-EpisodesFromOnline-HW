//
//  EpisodeListViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/7/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var seriesEpisodes: [Episode]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

}

extension EpisodeListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesEpisodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeTableViewCell, let episodes = seriesEpisodes else {
            return UITableViewCell()
        }

        xCell.setUp(using: episodes[indexPath.row])
        return xCell
    }
}

extension EpisodeListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedEpisodeVC = newStoryboard.instantiateViewController(withIdentifier: "detailedEpisodeVC") as? DetailedEpisodeViewController else{
            return
        }
        
        if let curEpisode = seriesEpisodes?[indexPath.row]{
            detailedEpisodeVC.currentEpisode = curEpisode
        }
        navigationController?.pushViewController(detailedEpisodeVC, animated: true)
    }
}
