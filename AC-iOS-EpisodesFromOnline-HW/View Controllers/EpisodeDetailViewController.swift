//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeAirdateLabel: UILabel!
    @IBOutlet weak var episodeSummaryLabel: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let episode = episode else { return }
        
        episodeImageView.image = nil
        episodeTitleLabel.text = episode.name
        episodeSeasonLabel.text = "Season: " + (episode.season?.description ?? "")
        episodeNumberLabel.text = "Episode: " + (episode.number?.description ?? "")
        episodeAirdateLabel.text = "Airdate: " + (episode.airdate ?? "")
        episodeSummaryLabel.text = episode.summary?.html2String ?? "No information available."
        
        if let imageURL = episode.image?.original {
            spinner.isHidden = false
            spinner.startAnimating()
            
            let completion: (UIImage?) -> Void = { (onlineImage: UIImage?) in
                self.episodeImageView.image = onlineImage
                DispatchQueue.main.async {
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                }
            }
            ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: { print($0) })
            
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
            self.episodeImageView.image = #imageLiteral(resourceName: "no-image-icon")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
