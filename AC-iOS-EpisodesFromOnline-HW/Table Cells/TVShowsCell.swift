//
//  TVShowsCell.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import QuartzCore

class TVShowsCell: UITableViewCell {
    
    @IBOutlet weak var seriesImageView: UIImageView!
    @IBOutlet weak var  seriesTitleLabel: UILabel!
    @IBOutlet weak var  seriesRatingLabel: UILabel!
    @IBOutlet weak var tvShowActivityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellApperance()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCellApperance () {
        seriesTitleLabel.layer.cornerRadius = 3.0
        seriesTitleLabel.clipsToBounds = true
        seriesRatingLabel.layer.cornerRadius = 3.0
        seriesRatingLabel.clipsToBounds = true
        seriesTitleLabel.adjustsFontSizeToFitWidth = true
        seriesRatingLabel.adjustsFontSizeToFitWidth = true
        let borderColor = UIColor.white
        seriesRatingLabel.layer.borderWidth = 0.5
        seriesRatingLabel.layer.borderColor = borderColor.cgColor
        seriesTitleLabel.layer.borderWidth = 0.5
        seriesTitleLabel.layer.borderColor = borderColor.cgColor
        
        
//        seriesRatingLabel.backgroundColor = seriesRatingLabel.backgroundColor?.withAlphaComponent(0.5)
//        seriesRatingLabel.layer.shadowColor = UIColor.white.cgColor
//        seriesRatingLabel.layer.shadowRadius = 4.0
//        seriesRatingLabel.layer.shadowOpacity = 0.9
//        let size = CGSize(width: 0, height: 0)
//        seriesRatingLabel.layer.shadowOffset = size
//        seriesRatingLabel.layer.masksToBounds = false
        
    }
}
