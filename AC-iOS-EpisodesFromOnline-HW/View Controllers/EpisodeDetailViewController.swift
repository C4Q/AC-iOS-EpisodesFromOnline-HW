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
    
    
    
    var anEpisode: Episode?
    
    func setlabelsAndImage() {
        nameLabel.text = anEpisode?.name
        seasonEpisodeLabel.text? = "Season \(anEpisode?.season ?? 0)"
        episodeLabel.text = "Episode \(anEpisode?.number ?? 0)"
        episodeSummaryTextView.text? = "\(anEpisode?.summary ?? "")"
        
        if let episodeImageUrl = anEpisode?.image?.original {
            let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.episodeImageView.image = onlineImage
                
            }
            
            
            
            ImageAPIClient.manager.getImage(from: episodeImageUrl, completionHandler: getImage, errorHandler: {print($0)})
        }
        else {
            episodeImageView.image = #imageLiteral(resourceName: "noImage")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setlabelsAndImage()
    }

}
