//
//  TVShowTableViewCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Reiaz Gafar on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
