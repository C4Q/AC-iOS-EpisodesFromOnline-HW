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
    
    var showID: String?
    
    var allEpisodesTuple = [(key: Int, value: [Episode])]() {
        didSet {
            self.episodesTableView.reloadData()
        }
    }
    
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
            self.allEpisodesTuple = Episode.makeTupleBySeasons(allEpisodes: showEpisdoes)
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            guard let indexSelected = episodesTableView.indexPathForSelectedRow else { return }
            let selectedEpisodeInSeason = indexSelected.row
            let selectedSeason = indexSelected.section
            destination.episode = self.allEpisodesTuple[selectedSeason].value[selectedEpisodeInSeason]
        }
    }

}

extension ShowEpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodesTuple[section].value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(allEpisodesTuple[section].key)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allEpisodesTuple.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath)
        let season = indexPath.section
        let episode = indexPath.row
        let selectedEpisode = self.allEpisodesTuple[season].value[episode]
        if let episodeCell = episodeCell as? CustomEpisodeTableViewCell {
            episodeCell.episodesSpinner.startAnimating()
            episodeCell.episodesSpinner.isHidden = false
            episodeCell.episodeNameLabel.text = selectedEpisode.name
            episodeCell.seasonEpisodeNumberLabel.text = "S:\(selectedEpisode.season)  E:\(selectedEpisode.number)"
            episodeCell.episodeImage.image = nil
            episodeCell.setNeedsLayout()
            guard let imageUrlStr = selectedEpisode.image else {
                stopAndHideSpinner(cell: episodeCell)
                episodeCell.episodeImage.image = UIImage(named: "episodeImageNotFound")
                return episodeCell
            }
            let completion: (UIImage) -> Void = {(onlineShowImage: UIImage) in
                episodeCell.episodeImage.image = onlineShowImage
                episodeCell.setNeedsLayout()
                self.stopAndHideSpinner(cell: episodeCell)
            }
            let episodeImageUrlStr = imageUrlStr.medium
            ImageAPIClient.manager.getImage(from: episodeImageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        }
        return episodeCell
    }
    
    func stopAndHideSpinner(cell: CustomEpisodeTableViewCell) {
        cell.episodesSpinner.stopAnimating()
        cell.episodesSpinner.isHidden = true
    }

}
