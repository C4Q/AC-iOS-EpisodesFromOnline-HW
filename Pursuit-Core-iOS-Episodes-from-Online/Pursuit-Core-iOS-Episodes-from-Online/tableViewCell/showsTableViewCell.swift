//
//  showsTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class showsTableViewCell: UITableViewCell {
    @IBOutlet weak var showsImage: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
