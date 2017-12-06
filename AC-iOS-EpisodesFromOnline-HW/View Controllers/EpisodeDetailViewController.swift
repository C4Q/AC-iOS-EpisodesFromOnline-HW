//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var episodeInfo: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var episode: Episode!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTitle.text = episode.name
        episodeInfo.text = "Season: " + episode.season.description + " " + "Episode: " + episode.number.description
        if episode.image == nil{
            episodeImage.image = #imageLiteral(resourceName: "image_not_available")
            activityIndicator.stopAnimating()
        }else{ setImage() }
        
        if episode.summary ==  nil{
            episodeDescription.text = "No Summary Available"
        }else{
        let summary = episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        episodeDescription.text = summary
    }
}
    
    
    func setImage(){
        guard let imageUrlStr = episode.image?.original else{
            episodeImage.image = #imageLiteral(resourceName: "image_not_available")
            return
        }
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.episodeImage.image = onlineImage
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.startAnimating()
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
    }


}
