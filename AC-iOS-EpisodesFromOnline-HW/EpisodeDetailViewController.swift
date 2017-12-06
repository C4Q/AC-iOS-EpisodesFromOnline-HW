//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var epTitleLabel: UILabel!
    @IBOutlet weak var epSeasonLabel: UILabel!
    @IBOutlet weak var epSummaryText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var episodes: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        spinner.sizeToFit()
        spinner.isHidden = false
        spinner.startAnimating()
        
        dateLabel.text = "Date aired: \(episodes.airdate != nil ? episodes.airdate! : "No date info available")"
        epSummaryText.text = "\(episodes.summary != nil ? episodes.summary!.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "") : "No summary available")"
        epTitleLabel.text = episodes.name
        epSeasonLabel.text = "\(episodes.season != nil ? "Season: \(episodes.season!) Episode: \(episodes.number!)" : "Season info not available")"
        
            guard let imageUrlStr = self.episodes.image?.original else {
                self.episodeImageView.image = #imageLiteral(resourceName: "noImage")
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                return
            }
            let completion = {(onlineImage: UIImage) in
                self.episodeImageView.image = onlineImage
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
            ImageAPIClient.manager.getImage(from: imageUrlStr,
                                            completionHander: completion,
                                            errorHander: {print($0)})
    }
}
