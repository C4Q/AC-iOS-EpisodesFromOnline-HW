//
//  EpisodeListViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var episodesTableView: UITableView!
    
    var show: Show!
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        EpisodeAPIClient.manager.getEpisodes(
            from: show.id,
            completionHandler: { (onlineEpisodes) in
                self.episodes = onlineEpisodes
                if onlineEpisodes.count == 0 {
                    let alertController = UIAlertController(title: "ERROR", message: "No episodes available", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                self.episodesTableView.reloadData()
        },
            errorHandler: { (appError) in
                let alertController = UIAlertController(title: "ERROR", message: "Could not load episodes:\n\(appError)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                
                self.present(alertController, animated: true, completion: nil)
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let destinationVC = segue.destination as? EpisodeDetailViewController,
            let selectedCell = sender as? EpisodeTableViewCell,
            let indexPath = episodesTableView.indexPath(for: selectedCell) {
            destinationVC.episode = episodes[indexPath.row]
        }
    }
}

extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? EpisodeTableViewCell {
            performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
        }
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        let currentEpisode = episodes[indexPath.row]
        
        if let episodeCell = cell as? EpisodeTableViewCell {
            episodeCell.episodeImageView.image = nil
            episodeCell.setNeedsLayout()
            episodeCell.activityIndicator.startAnimating()
            episodeCell.activityIndicator.isHidden = false
            
            episodeCell.titleLabel.text = currentEpisode.name
            episodeCell.seasonEpisodeLabel.text = "Season \(currentEpisode.season) | Episode \(currentEpisode.number)"
            
            guard let image = currentEpisode.image else {
                episodeCell.episodeImageView.image = #imageLiteral(resourceName: "noImage")
                
                episodeCell.activityIndicator.isHidden = true
                episodeCell.activityIndicator.stopAnimating()
                
                episodeCell.setNeedsLayout()
                
                return episodeCell
            }
            
            //set up image
            ImagesAPIClient.manager.getImage(
                from: image.mediumURL,
                completionHandler: { (onlineImage) in
                    episodeCell.episodeImageView.image = onlineImage
                    episodeCell.activityIndicator.isHidden = true
                    episodeCell.activityIndicator.stopAnimating()
                    
                    episodeCell.setNeedsLayout()
            },
                errorHandler: { (appError) in
                    print(appError)
            })
            
            return episodeCell
        }
        
        return cell
    }
}
