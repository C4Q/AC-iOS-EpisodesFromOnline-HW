//
//  DetailedViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeNumberLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var largeImageView: UIImageView!
    
    var anEpisode: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    func loadData() {
        episodeNameLabel.text = "Episode Unavailable"
        seasonAndEpisodeNumberLabel.text = "Data Unavailable"
        descriptionTextView.text = "Summary Unavailable"
        
        guard let anEpisode = anEpisode else {return}
        
        episodeNameLabel.text = "Name: \(anEpisode.name)"
        seasonAndEpisodeNumberLabel.text = "Season: \(anEpisode.season) / Episode: \(anEpisode.number)"
        descriptionTextView.text = anEpisode.summary
        largeImageView.image = nil
        
        //PUT IMAGE API HERE
        guard let urlStr = anEpisode.image?.original else {return}
        spinner.startAnimating()
        spinner.isHidden = false
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.largeImageView.image = onlineImage
            
        }
        ImageAPIClient.manager.getImage(from: urlStr,
                                        completionHandler: setImageToOnlineImage,
                                        errorHandler: {print($0)})
        spinner.stopAnimating()
        spinner.isHidden = true
    }

}
