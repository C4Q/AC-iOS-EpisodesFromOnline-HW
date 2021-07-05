//
//  SongTableViewCell.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/11/19.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showEpisode: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
