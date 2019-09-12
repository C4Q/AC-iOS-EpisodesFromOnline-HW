//
//  ShowTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var showImageView: UIImageView!
    
    @IBOutlet weak var showLabel: UILabel!
    
    @IBOutlet weak var activity2: UIActivityIndicatorView!
    @IBOutlet weak var seasonNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func activityStatusOFF() {
        showImageView.isHidden = false
        activity2.stopAnimating()
        activity2.isHidden = true
    }
    func activityStatusON() {
        showImageView.isHidden = true
        activity2.startAnimating()
        activity2.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
