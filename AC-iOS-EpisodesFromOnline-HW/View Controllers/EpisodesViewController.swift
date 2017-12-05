//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodes = [Episodes?]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    var tvSerial: TVSeries!
    
    
    
    func loadData() {
        let urlStr = "http://api.tvmaze.com/shows/\(tvSerial.show.id)/episodes"
        let completion: ([Episodes]) -> Void = { (onlineObject:[ Episodes]) in
            self.episodes = onlineObject
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            //Refactor to use App Error
            print(error)
        }
        EpisodesAPIClient.manager.getAllEpisodes(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.navigationItem.title = "\(tvSerial.show.name)"
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailedViewController {
            destination.episode = episodes[episodeTableView.indexPathForSelectedRow!.row]
        }
    }
    
}



extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath)
        if let cell = cell as? EpisodesCell {
            cell.episodesTitleLabel.text = episode?.name
            cell.episodesSeasonAndEpisodeNumbersLabel.text = "Season \(episode?.season.description ?? "N/A") : Episode: \(episode?.number.description ??  "N/A" )"
            cell.episodesImageView.image = nil
            //For image
            guard let imageStr = episode?.image?.medium else { return cell }
            cell.episodeActivityIndicator.startAnimating()
            guard let urlStr = URL(string: imageStr) else { return cell }
            DispatchQueue.main.async {
                guard let rawImageData = try? Data(contentsOf: urlStr) else {return}
                DispatchQueue.main.async {
                    guard let onlineImage = UIImage(data: rawImageData) else {return}
                    cell.episodesImageView.image = onlineImage
                    cell.setNeedsLayout()
                    cell.episodeActivityIndicator.stopAnimating()
                }
            }
        }
        
        return cell
    }
    
    
}


