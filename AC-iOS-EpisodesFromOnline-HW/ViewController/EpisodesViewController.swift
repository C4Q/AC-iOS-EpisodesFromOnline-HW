//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {

    var episodeURL: String? 
        
    var episodes = [Episode]() {
        didSet {
            loadEpisodes()
            episodeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self; episodeTableView.dataSource = self
        loadEpisodes()
    }
    
    func loadEpisodes() {
        guard let episodeURL = episodeURL else { return }
        EpisodeAPIClient.manager.getEpisodes(from: episodeURL, completionHandler: {self.episodes = $0}, errorHandler: { print($0) })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            destination.selectedEpisode = episodes[self.episodeTableView.indexPathForSelectedRow!.row]
        }
    }
    
}
extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell else {return UITableViewCell()}
        
        episodeCell.nameLabel.text = episode.name
        let season = episode.season?.description ?? "N/A"
        let name = episode.number?.description ?? "N/A"
        episodeCell.episodeLabel.text = "Season:\(season) Episode:\(name)"
        episodeCell.episodeImageView.image = nil
        guard let imageURL = episode.image?.original else {return episodeCell}
        episodeCell.setNeedsLayout()
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: {episodeCell.episodeImageView.image = $0}, errorHandler: {print($0)})
        return episodeCell
    }
}
