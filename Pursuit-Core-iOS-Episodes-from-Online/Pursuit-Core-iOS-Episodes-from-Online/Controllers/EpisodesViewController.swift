//
//  EpisodesViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    
    // MARK: Properties
    var show: ShowWrapper!
    var episodes = [Episode]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        loadData()
    }
    
    // MARK: Private Methods
    private func loadData() {
        EpisodeAPIClient.shared.getEpisodes(showID: String(show.show.id)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodesFromOnline):
                    self.episodes = episodesFromOnline
                case .failure(let error):
                    print("What's happening?")
                    print(error)
                }
            }
        }
    }
    
    // MARK: Navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEpisodeDVC" {
            guard let episodeDVC = segue.destination as? EpisodeDetailViewController else {
                fatalError()
            }
            guard let selectedIndexPath = episodeTableView.indexPathForSelectedRow else {
                fatalError()
            }
            episodeDVC.episode = episodes[selectedIndexPath.row]
        }
    }
    
}

// MARK: Extensions
extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cells = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeTableViewCell {
            cells.episodeName.text = episodes[indexPath.row].name
            cells.seasonAndEpisodeNumbers.text = episodes[indexPath.row].seasonAndEpisode
            if let urlStr = episodes[indexPath.row].image?.medium {
                ImageHelper.shared.fetchImage(urlImage: urlStr) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let imageFromOnline):
                            cells.episodeImage.image = imageFromOnline
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            return cells
        }
        return UITableViewCell()
    }
    

}
