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
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    var episodeDetail: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spiner.isHidden = true
        loadLabel()
    }
    
    func loadLabel() {
        self.episodeNameLabel.text = episodeDetail.name
        self.seasonLabel.text = "Season \(episodeDetail.season)"
        self.episodeLabel.text = "Episode \(episodeDetail.number)"
        if let summary = episodeDetail.summary {
            self.episodeDescription.text = summary
        } else {
            self.episodeDescription.text = "No summary found"
        }
        if let image = episodeDetail.image, let urlImage = image.original {
            self.spiner.isHidden = false
            self.spiner.startAnimating()
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.episodeImageView.image = onlineImage
                self.episodeImageView.setNeedsLayout() //Makes the image load as soon as it's ready
                self.spiner.stopAnimating()
                self.spiner.isHidden = true
            }
            let errorHandler: (Error) -> Void = {(error: Error) in
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            ImageAPIClient.manager.getImage(from: urlImage,
                                            completionHandler: completion,
                                            errorHandler: errorHandler)
        } else {
            self.episodeImageView.image = #imageLiteral(resourceName: "noimage")
        }
    }

}
