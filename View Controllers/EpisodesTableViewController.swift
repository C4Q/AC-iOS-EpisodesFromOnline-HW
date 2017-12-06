//
//  EpisodesTableViewController.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class EpisodesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedShowId: Int!
    var episodes = [Episode]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes()
        self.tableView.dataSource = self
    }

    func loadEpisodes() {
        let urlStr = "http://api.tvmaze.com/shows/\(selectedShowId!)/episodes"
        let setEpisodesToOnlineEpisodes: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: setEpisodesToOnlineEpisodes, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Episode Detail Segue" else {return}
        guard let cell = sender as? EpisodeTableViewCell else {return}
        guard let episodeDetailViewController = segue.destination as? EpisodeDetailViewController else {return}
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        let selectedEpisode = episodes[index]
        let imageToPass = cell.thumbnailImageView.image
        
        episodeDetailViewController.selectedEpisode = selectedEpisode
        episodeDetailViewController.theImageFromThePreviousControllerSoNoMoreAPICalls = imageToPass
    }
}

extension EpisodesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        cell.nameLabel.text = episode.name
        cell.seasonAndEpisodeLabel.text = "s: \(episode.season), e: \(episode.number)"
        cell.thumbnailImageView.image = nil
        cell.episodeSpinner.isHidden = false
        cell.episodeSpinner.startAnimating()
        if let urlStr = episode.image?.medium {
            let setThumbnailToOnline: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.thumbnailImageView.image = onlineImage
                cell.episodeSpinner.isHidden = true
                cell.episodeSpinner.stopAnimating()
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setThumbnailToOnline, errorHandler: {print($0)})
        } else {
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "NoImg")
            cell.episodeSpinner.isHidden = true
            cell.episodeSpinner.stopAnimating()
        }
        return cell
    }
}
