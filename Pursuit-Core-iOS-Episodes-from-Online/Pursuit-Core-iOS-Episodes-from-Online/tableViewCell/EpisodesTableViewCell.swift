//
//  EpisodesTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var episodesImage: UIImageView!
    
    @IBOutlet weak var episodeLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
   
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
