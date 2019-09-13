//
//  ShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    //MARK: IBOutlet and Properties
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodes = [TVEpisodes]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    var currentTVShowURL = String()
    
    private func getSelectedTVShowData(newTVShowURL: String){
        TVEpisodes.getTVEpisode(showURL: newTVShowURL) {(result) in DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let newTVShowData):
                    self.episodes = newTVShowData
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
    }
}

//MARK: Datasource Methods
extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEpisode = episodes[indexPath.row]
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        if let episodeImage = currentEpisode.image?.original{
            ImageHelper.shared.fetchImage(urlString: episodeImage) { (result) in DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let episodeImage):
                    episodeCell.tvEpisodeImage.image = episodeImage
                    }
                }
            }
        }
        episodeCell.episodeNameLabel.text = currentEpisode.name
        episodeCell.episodeSeasonLabel.text = "S\(currentEpisode.season) E\(currentEpisode.number)"
        return episodeCell
    }
}


extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

