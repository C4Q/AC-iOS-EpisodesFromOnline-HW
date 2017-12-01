//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    var episode: Episode?
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let episode = episode else { return }
        episodeNameLabel.text = episode.name
        episodeSeasonLabel.text = episode.season.description
        episodeNumberLabel.text = episode.number.description
        episodeSummaryTextView.text = episode.summary
        loadImage()
    }
    
    func loadImage() {
        guard let imageURLStr = episode?.image?.original else { return }
        let completion: (UIImage) -> Void = {(onlineEpisodeImage: UIImage) in
            self.episodeImage.image = onlineEpisodeImage
            self.episodeImage.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: completion, errorHandler: {print($0)})
    }
    

}
