//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    var showName = ""
    
    var episodeEndpoint: String! {
        didSet {
            print(episodeEndpoint)
            EpisodeAPIClient.manager.getEpisodes(from: episodeEndpoint,
                                                 completionHandler: {self.episodes = $0},
                                                 errorHandler: {print($0)})
        }
    }
    
    var episodes: [Episode]? {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeTableView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let destination = segue.destination as! DetailViewController
            let episodeCell = sender as! EpisodeTableViewCell
            let index = episodeTableView.indexPath(for: episodeCell)!.row
            destination.episode = episodes?[index]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = showName

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = "\(showName) Episodes"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: Table View Data Source
extension EpisodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = episodeTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! EpisodeTableViewCell
        customCell.episodeImageView.image = nil
        let index = indexPath.row
        
        if episodes!.isEmpty {
            tableView.backgroundColor = .black
        }
        
        guard let currentEpisode = episodes?[index] else { return customCell }
        
        customCell.nameLabel.text = currentEpisode.name
        customCell.episodeLabel.text = "Season: \(currentEpisode.season) Number: \(currentEpisode.number)"
        customCell.imageLoadingSpinner.startAnimating()
        ImageDownloader.manager.getImage(from: currentEpisode.image?.medium ?? "noImage",
                                         completionHandler: { customCell.episodeImageView?.image = UIImage(data: $0)
                                                                customCell.imageLoadingSpinner.stopAnimating()
                                                                customCell.setNeedsLayout() },
                                        errorHandler: { customCell.episodeImageView?.image = UIImage(named: "noImage")
                                                        customCell.imageLoadingSpinner.stopAnimating() })
        
        return customCell
    }
    
}
