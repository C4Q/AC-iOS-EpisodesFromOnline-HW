//
//  EpisodeTableViewCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var showPictureImageView: UIImageView!
    
    @IBOutlet weak var showNameLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeNumbersLabel: UILabel!
    
    @IBOutlet weak var episodeShowSpinner: UIActivityIndicatorView!
    
}
