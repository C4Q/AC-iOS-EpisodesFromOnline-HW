//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var seasonAndEpisode: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeName.text = episode?.name
        episodeDescription.text = episode?.summary
        seasonAndEpisode.text = "E: \(episode?.season) S: \(episode?.number)"
        loadImage()
        
    }
    
    func loadImage() {
        guard let imageURLStr = episode?.image?.original else {
            return
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.episodeImage.image = onlineImage
            self.episodeName.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: completion, errorHandler: {print($0)})
    }
    
}
