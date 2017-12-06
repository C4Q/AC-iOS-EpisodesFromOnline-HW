//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var largeEpisodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var episodeSelected: Episodes!


    override func viewDidLoad() {
        super.viewDidLoad()
        episodeNameLabel.text = episodeSelected.name
        seasonLabel.text = "Season \(episodeSelected.season.description)"
        episodeLabel.text = "Episode \(episodeSelected.number.description)"
        if episodeSelected.summary == nil {
            summaryTextView.text = "No summary available"
        } else {
            summaryTextView.text = episodeSelected.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
        setImage()
    }

    func setImage() {
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.largeEpisodeImage.image = onlineImage
        }

        if let image = episodeSelected.image?.original {
            ImageAPIClient.manager.getImage(from: image,
                                            completionHandler: completion,
                                            errorHandler: {print($0)})
        } else {
            self.largeEpisodeImage.image = #imageLiteral(resourceName: "NoImage")
        }
    }
    
//    replace occurences of
//    check if its not nil
}
