//
//  EpisodesDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesDetailViewController: UIViewController {
    
    var tvEpisodeInfo: EpisodeWrapper!

    @IBOutlet weak var episodeStillImageView: UIImageView!
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeNumberLabel: UILabel!
    
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    @IBOutlet weak var episodeDetailSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTitleLabel.text = tvEpisodeInfo.name
        seasonAndEpisodeNumberLabel.text = "S: " + tvEpisodeInfo.season.description + " " + "E: " + tvEpisodeInfo.number.description
        episodeSummaryTextView.text = removeHTMLtags(from: tvEpisodeInfo.summary!)
        episodeDetailSpinner.isHidden = false
        episodeDetailSpinner.startAnimating()
        loadImage()
    }
    
    func removeHTMLtags(from summary: String) -> String {
        return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func loadImage() {
        let completion: (UIImage) -> Void = { (tvEpisodeImage: UIImage) in
            self.episodeDetailSpinner.isHidden = true
            self.episodeDetailSpinner.stopAnimating()
            self.episodeStillImageView.image = tvEpisodeImage
            self.episodeStillImageView.setNeedsLayout()
        }
        guard let image = tvEpisodeInfo.image else {
            return
        }
        ImageAPIClient.manager.getImage(from: image.original, completionHandler: completion, errorHandler: {print($0)})
    }
    
}
