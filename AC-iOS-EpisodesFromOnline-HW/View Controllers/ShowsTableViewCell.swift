//
//  ShowTableViewCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spiner.isHidden = true
    }

    
    
}
