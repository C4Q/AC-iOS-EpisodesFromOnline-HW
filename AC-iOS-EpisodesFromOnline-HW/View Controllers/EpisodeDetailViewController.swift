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
    @IBOutlet weak var episodeSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let episode = episode else { return }
        episodeSpinner.startAnimating()
        episodeNameLabel.text = episode.name
        episodeSeasonLabel.text = "Season: \(episode.season.description)"
        episodeNumberLabel.text = "Episode: \(episode.number.description)"
        episodeSummaryTextView.text = removeHTMLtags(from: episode.summary) ?? "No summary found"
        loadImage()
    }
    
    /*
     https://stackoverflow.com/questions/40530745/swift-3-take-out-html-tags-from-string-taken-from-json-web-url
     used as reference to remove html tags from episode summary
    */
    func removeHTMLtags(from summary: String?) -> String? {
        guard let summary = summary else { return nil }
        return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func loadImage() {
        guard let episode = episode else { return }
        guard let episodeImage = episode.image else {
            stopAndHideSpinner()
            self.episodeImage.image = UIImage(named: "episodeImageNotFound")
            return
        }
        let imageURLStr = episodeImage.original
        let completion: (UIImage) -> Void = { (onlineEpisodeImage: UIImage) in
            self.episodeImage.image = onlineEpisodeImage
            self.episodeImage.setNeedsLayout()
            self.stopAndHideSpinner()
        }
        ImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: completion, errorHandler: {print($0)} )
    }
    
    func stopAndHideSpinner() {
        self.episodeSpinner.isHidden = true
        self.episodeSpinner.stopAnimating()
    }
    
}
