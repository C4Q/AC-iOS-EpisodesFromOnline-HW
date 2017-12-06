//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    
    //Outlets
    
    @IBOutlet weak var textScroll: UITextView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variables
    var episodes: Episode!
    
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        var episodeInfo: String = ""
        var name: String = ""
        var info: String = ""
        
        if episodes.name != nil {
            name = episodes.name!
        } else {
            name = "No Name"
        }
        
        //        if episodes.summary != nil {
        //            info = episodes.summary!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        //        } else {
        //            info = "No Summary"
        //        }
        //
        
        
        
        if episodes.summary == nil || episodes.summary == "" {
            info = "No Summary"
        } else {
            info = episodes.summary!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
        
        
        
        episodeInfo =
        """
        Episode: \(name)
        
        S: \(episodes.season) E: \(episodes.number)
        
        Description: \(info)
        
        """
        
        textScroll.text = episodeInfo
        
        picture.image = nil
     
        if let imageUrlStr = episodes.image?.medium{
            
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.picture.image = onlineImage
            //Activity Indicator Stop Animation
            self.activityIndicator.stopAnimating()
        }
        
        //Activity Indicator Start Animation
        self.activityIndicator.startAnimating()
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        
        
        }else {
            self.activityIndicator.stopAnimating()
            picture.image = #imageLiteral(resourceName: "photo_not_available_large")
            
        }
        
        
        
        
    }





}
