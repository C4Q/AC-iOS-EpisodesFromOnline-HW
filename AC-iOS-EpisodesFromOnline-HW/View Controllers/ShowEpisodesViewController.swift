//
//  ShowEpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowEpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodesTableView: UITableView!
    var allEpisodes = [Episode]()
    var showID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesTableView.delegate = self
        self.episodesTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        guard let showID = showID else { return }
        let urlStr = "http://api.tvmaze.com/shows/\(showID)?embed=episodes"
        let completion: ([Episode]) -> Void = {(showEpisdoes: [Episode]) in
            self.allEpisodes = showEpisdoes
            self.episodesTableView.reloadData()
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            destination.episode = self.allEpisodes[(self.episodesTableView.indexPathForSelectedRow?.row)!]
        }
    }

}

extension ShowEpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath)
        let selectedEpisode = self.allEpisodes[indexPath.row]
        if let episodeCell = episodeCell as? CustomEpisodeTableViewCell {
            episodeCell.episodeNameLabel.text = selectedEpisode.name
            episodeCell.seasonEpisodeNumberLabel.text = "S:\(selectedEpisode.season)  E:\(selectedEpisode.number)"
            //episodeCell.episodeImage.image = nil
            episodeCell.episodeImage.image = UIImage(named: "episodeimageNF")
            guard let imageUrlStr = selectedEpisode.image?.medium else {
                //episodeCell.episodeImage.image = UIImage(named: "episodeimageNF")
                return episodeCell
            }
            let completion: (UIImage) -> Void = {(onlineShowImage: UIImage) in
                episodeCell.episodeImage.image = onlineShowImage
                episodeCell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        }
        return episodeCell
    }
    
    
}
