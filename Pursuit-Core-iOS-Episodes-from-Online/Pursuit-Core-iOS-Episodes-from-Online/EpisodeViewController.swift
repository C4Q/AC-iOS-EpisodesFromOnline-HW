//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var passedObj: Show?
    
    var episodes = [Episode](){
        didSet{
            DispatchQueue.main.async {
                self.episodeTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(passedObj?.name ?? "Show")"
        delegates()
        loadData(seasonID: passedObj!.id)
    }
    
    func delegates(){
        episodeTableView.dataSource = self
    }
    
    func loadData(seasonID: Int){
        TVMazeAPIClient.fetchEpisodes(episodeNumber: seasonID) { (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self.displayAlertController(title: "ERROR", message: "\(appError)")
                }
            case .success(let episodes):
                self.episodes = episodes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDVC = segue.destination as? EpisodeDetailViewController, let indexPath = episodeTableView.indexPathForSelectedRow else {
            fatalError("failed to segue")
        }
        
        let episode = episodes[indexPath.row]
        episodeDVC.passedObj = episode
    }

}

extension EpisodeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? ShowCell else {
            fatalError("failed to deque cell or downcast to customcell")
        }
        let episode = episodes[indexPath.row]
        episodeCell.configureEpisodeCell(for: episode)
        return episodeCell
    }
    
    
}
