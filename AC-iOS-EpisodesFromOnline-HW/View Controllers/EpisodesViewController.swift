//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    var showID: String!

    var episodeArr = [EpisodeWrapper]() {
        didSet {
            self.episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        //API goes here
        let url = "http://api.tvmaze.com/shows/\(showID!)/episodes"
        let completion: ([EpisodeWrapper]) -> Void = {(onlineTVShowEpisodes: [EpisodeWrapper]) in
            self.episodeArr = onlineTVShowEpisodes
            print(onlineTVShowEpisodes.count)
        }
        EpisodeAPIClient.manager.getTVEpisodes(from: url,
                                       completionHandler: completion,
                                       errorHandler: {print($0)})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeContent = self.episodeArr[indexPath.row]
//        dump(episodeContent)
        guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: "ShowSearchResults", for: indexPath) as? EpisodeTableViewCell else
        {return UITableViewCell()}
        cell.episodeShowSpinner.isHidden = false
        cell.episodeShowSpinner.startAnimating()
        cell.showNameLabel.text = episodeContent.name
        cell.seasonAndEpisodeNumbersLabel.text = "S: " + episodeContent.season.description + " " + "E: " + episodeContent.number.description
        let completion: (UIImage) -> Void = {(onlineShowImage: UIImage) in
            cell.episodeShowSpinner.isHidden = true
            cell.episodeShowSpinner.stopAnimating()
            cell.showPictureImageView.image = onlineShowImage
            cell.setNeedsLayout()
        }
        guard let image = episodeContent.image else {
            return cell
        }
        ImageAPIClient.manager.getImage(from: image.medium, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesDetailViewController {
            let selectedRow = self.episodesTableView.indexPathForSelectedRow!.row
            let selectedEpisode = self.episodeArr[selectedRow]
            destination.tvEpisodeInfo = selectedEpisode
        }
    }
    
}
