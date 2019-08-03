//
//  EpisodeDetailedViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailedViewController: UIViewController {
    
    var episode: Episodes!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeSeasonNumberEpisodeNumberLabel: UILabel!
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeNameLabel.text = episode.name
        episodeSeasonNumberEpisodeNumberLabel.text = "Season \(episode?.season.description ?? "N/A") : Episode: \(episode?.number.description ??  "N/A" )"
        var nilSummary: String {
            switch episode.summary {
            case _ where episode.summary == "" || episode.summary == nil:
                return "No description available"
            default:
                return episode.summary!
            }
        }
        
        
       let htmlChars = "<[^>]+>"
        episodeSummaryTextView.text = nilSummary.replacingOccurrences(of: htmlChars, with: "", options: .regularExpression, range: nil)
        episodeImageView.image = nil
        guard let imageStr = episode.image?.original else { return }
        guard let urlStr = URL(string: imageStr) else { return }
        DispatchQueue.main.async {
            guard let rawImageData = try? Data(contentsOf: urlStr) else {return}
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImageData) else {return}
                self.episodeImageView.image = onlineImage
                self.episodeImageView.setNeedsLayout()
            }
         
        }
    }
    
}
