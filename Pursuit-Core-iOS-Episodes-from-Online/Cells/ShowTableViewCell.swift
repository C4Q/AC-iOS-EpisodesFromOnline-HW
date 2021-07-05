//
//  ShowTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by hildy abreu on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showRatingLabel: UILabel!
    
    @IBOutlet weak var showTitleLabel: UILabel!
    
    @IBOutlet weak var showImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
