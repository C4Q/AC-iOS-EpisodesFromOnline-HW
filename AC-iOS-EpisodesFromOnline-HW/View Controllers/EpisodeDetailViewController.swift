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
    
    
    //Variables
    var episodes: Episode!
    var episodeInfo: String = ""
    var name: String = ""
    var info: String = ""
    
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        
     
        guard let imageUrlStr = episodes.image?.medium else {
         return picture.image = #imageLiteral(resourceName: "photo_not_available_large")
            
        }
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.picture.image = onlineImage
        }
        
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        
        
        if episodes.name != nil {
            name = episodes.name!
        } else {
            name = "No Name"
        }
        
        if episodes.summary != nil {
            info = episodes.summary!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        } else {
            info = "No Summary"
        }
        
        
      episodeInfo =
        """
        Episode: \(name)
        
        S: \(episodes.season) E: \(episodes.number)
        
        Description: \(info)

        """
        
        textScroll.text = episodeInfo
        
        
        
        
        
        
    }





}
