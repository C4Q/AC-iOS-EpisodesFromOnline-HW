//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        setUpUI()
    }
    
    func setUpUI() {
        titleLabel.text = episode.name
        seasonLabel.text = "Season \(episode.season)"
        episodeLabel.text = "Episode \(episode.number)"
        let summaryText = episode.summary ?? "No summary available."
        
        //if summary exists but is just an empty string
        summaryTextView.text = (summaryText != "") ? summaryText : "No summary available."
        
        setUpImages()
    }
    
    func setUpImages() {
       
        guard let image = episode.image else {
            episodeImageView.image = #imageLiteral(resourceName: "noImage")
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            return
        }
        ImagesAPIClient.manager.getImage(
            from: image.originalURL,
            completionHandler: { (onlineImage) in
                self.episodeImageView.image = onlineImage
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
        },
            errorHandler: {(appError) in
                print(appError)})
    }

}
