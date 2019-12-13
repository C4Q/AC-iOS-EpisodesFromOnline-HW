//
//  ShowCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showLabel:UILabel!
    
    func configureCell(for show: Show){
        showImage.getImage(withEndPointURLString: show.image.medium) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.showImage.image = image
                }
            }
        }
        let averageRating = String(show.rating.average ?? 0.0)
        showLabel.text = "\(show.name)\nRating: \(averageRating)"
    }
}
