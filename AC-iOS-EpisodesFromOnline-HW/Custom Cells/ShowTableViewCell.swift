//
//  ShowTableViewCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var showImageView: UIImageView!
    
    @IBOutlet weak var showTitleLabel: UILabel!
    
    @IBOutlet weak var showRatingLabel: UILabel!
    
    @IBOutlet weak var showSpinner: UIActivityIndicatorView!
    
}
