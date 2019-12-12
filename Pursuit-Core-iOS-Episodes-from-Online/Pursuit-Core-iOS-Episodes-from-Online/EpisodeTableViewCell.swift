//
//  EpisodeTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    override func prepareForReuse() {
           episodeImageView.image = nil
       }
}
