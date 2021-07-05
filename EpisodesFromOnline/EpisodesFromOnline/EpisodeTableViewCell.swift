//
//  EpisodeTableViewCell.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/13/19.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var episodeTitle: UILabel!
    
    @IBOutlet weak var episodeInfoLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
