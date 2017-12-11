//
//  EpisodesDetailedViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/11/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesDetailedViewController: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeDetails: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodeDetails()
        // Do any additional setup after loading the view.
    }
   
    var episode: Episode!
    
    func removeHtmlFromString(inPutString: String) -> String{
        
        return inPutString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func loadEpisodeDetails() {
        episodeName.text = episode.name
        episodeSeason.text = "Season: \(episode.season.description)"
        episodeNumber.text = "Episode Number: \(episode.number.description)"
        episodeDetails.text = removeHtmlFromString(inPutString: episode.summary)
        guard let imageURL = (episode.image?.original ?? episode.image?.medium) else {return}
        let setImage: (UIImage)->Void = { (onlineImage: UIImage) in
            self.episodeImage.image = onlineImage //set the image url
            self.episodeImage.setNeedsLayout() //updates image to ensure its correct while scrolling
        }
        let printErrors = {(error: Error) in print(error)}
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: setImage, errorHandler: printErrors)
    }
    
}
