//
//  ShowsTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class AllShowsTableViewCell: UITableViewCell {

    @IBOutlet var allshowsImageView: UIImageView!
    @IBOutlet var allShowsLabel: UILabel!
    
    @IBOutlet weak var activity1: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func activityStatusOFF() {
        allshowsImageView.isHidden = false
        activity1.stopAnimating()
        activity1.isHidden = true
    }
    func activityStatusON() {
        allshowsImageView.isHidden = true
        activity1.startAnimating()
        activity1.isHidden = false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
