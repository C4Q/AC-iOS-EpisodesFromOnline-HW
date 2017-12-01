//
//  CustomEpisodeTableViewCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Luis Calle on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class CustomEpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonEpisodeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
