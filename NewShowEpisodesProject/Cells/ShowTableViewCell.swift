//
//  ShowTableViewCell.swift
//  NewShowEpisodesProject
//
//  Created by hildy abreu on 10/12/19.
//  Copyright © 2019 hildy abreu. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {


    
    @IBOutlet weak var showImageView: UIImageView!
    
    
    @IBOutlet weak var showTitleLabel: UILabel!
    
    
    @IBOutlet weak var ratingLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
