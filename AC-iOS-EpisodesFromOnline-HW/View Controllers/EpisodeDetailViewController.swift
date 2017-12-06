//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
   
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    @IBOutlet weak var episodeLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    
    var anEpisode: Episode?
    
    func setlabelsAndImage() {
        spinner.isHidden = false
        spinner.startAnimating()
        nameLabel.text = anEpisode?.name
        seasonEpisodeLabel.text? = "Season \(anEpisode?.season ?? 0)"
        episodeLabel.text = "Episode \(anEpisode?.number ?? 0)"
        episodeSummaryTextView.text? = "\(anEpisode?.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "</i>", with: "").replacingOccurrences(of: "<i>", with: "") ?? "")"
        episodeImageView.image = nil
    
        if let episodeImageUrl = anEpisode?.image?.original {
            
            let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.episodeImageView.image = onlineImage
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                
            }
            ImageAPIClient.manager.getImage(from: episodeImageUrl, completionHandler: getImage, errorHandler: {print($0)})
            
        }
        else {
            spinner.isHidden = true
            episodeImageView.image = #imageLiteral(resourceName: "noImage")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setlabelsAndImage()
    }

}
