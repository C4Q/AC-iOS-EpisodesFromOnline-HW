//
//  EpisodesCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesCell: UITableViewCell {

    @IBOutlet weak var episodesImageView: UIImageView!
    @IBOutlet weak var episodesTitleLabel: UILabel!
    @IBOutlet weak var episodesSeasonAndEpisodeNumbersLabel: UILabel!
    @IBOutlet weak var episodeActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        episodesTitleLabel.layer.cornerRadius = 3.0
        episodesSeasonAndEpisodeNumbersLabel.layer.cornerRadius = 3.0
        episodesTitleLabel.clipsToBounds = true
        episodesSeasonAndEpisodeNumbersLabel.clipsToBounds = true
        episodesTitleLabel.adjustsFontSizeToFitWidth = true
        episodesSeasonAndEpisodeNumbersLabel.adjustsFontSizeToFitWidth = true
        let borderColor = UIColor.white
        episodesTitleLabel.layer.borderColor = borderColor.cgColor
        episodesSeasonAndEpisodeNumbersLabel.layer.borderColor = borderColor.cgColor
        episodesTitleLabel.layer.borderWidth = 0.5
        episodesTitleLabel.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
