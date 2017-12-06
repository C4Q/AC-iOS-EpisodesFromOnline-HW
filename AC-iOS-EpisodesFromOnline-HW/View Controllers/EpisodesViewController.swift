//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    var episodeURL: String?
    
    var episodes = [Episode]() {
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesTableView.dataSource = self
    }
    
    

    
    
    
    ///http://api.tvmaze.com/shows/\(showid)&embed=episodes
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let show = episodes[indexPath.row] // is this the right path?
        
        guard let episodeCell = episodesTableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as? CustomEpisodeCell else {return UITableViewCell() }
        
        episodeCell.episodeNameLabel.text = show.name
        episodeCell.episodeNumberLabel.text = "S: \(show.season), E: \(show.number)"
        
        
        guard let imageUrlStr = show.image.medium else {return episodeCell}
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            episodeCell.episodeImageView?.image = onlineImage
            episodeCell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return episodeCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            let selectedRow = self.episodesTableView.indexPathForSelectedRow!.row
            let selectedEpisode = self.episodes[selectedRow] /// filtered search or original shows array?
            destination.episode = selectedEpisode
        }
    }
}




