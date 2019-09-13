//
//  EpisodeListViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/6/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chosenShow: Int!
    var episodes = [Episode]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        let urlStr = "http://api.tvmaze.com/shows/\(chosenShow!)/episodes"
        let setEpisodesToOnlineEpisodes: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: setEpisodesToOnlineEpisodes, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EpisodeDetailViewController,
            let selectedEpisodeIndex = tableView.indexPathForSelectedRow else { return
        }
        guard let cell = sender as? EpisodeTableViewCell else{return}
        let selectedEpisodeImage = cell.episodeImageView.image
        
        destination.chosenEpisode = episodes[selectedEpisodeIndex.row]
        destination.chosenEpisodeImage = selectedEpisodeImage
        
        
    }
    
}

extension EpisodeListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        
        func stopActivityIndicator(){
            cell.activityIndicator.isHidden = true
            cell.activityIndicator.stopAnimating()
        }

        cell.episodeNameLabel.text = episode.name
        cell.seasonLabel.text = "S: \(episode.season) E: \(episode.number)"
        cell.episodeImageView.image = nil
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        if let urlStr = episode.image?.medium {
            let setThumbnailToOnline: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.episodeImageView.image = onlineImage
                stopActivityIndicator()
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setThumbnailToOnline, errorHandler: {print($0)})
        } else {
            //Assign placeholder image here
            stopActivityIndicator()
        }
        return cell
        
    }
}
