//
//  EpisodeTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/6/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
