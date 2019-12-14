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
    
    private var urlString:String? = ""
    
    override func prepareForReuse(){
        super.prepareForReuse()
        
        //emptyOut the image View
        showImage.image = nil
    }
    
    func configureCell(for show: Show){
        self.urlString = show.image?.medium
        guard let validImage = self.urlString else {
            DispatchQueue.main.async {
                self.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            return
        }
        
        showImage.getImage(withEndPointURLString: validImage) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self.urlString == validImage{
                        self.showImage.image = image
                    }
                }
            }
        }
        var averageRating = String(show.rating.average ?? 0.0)
        if averageRating == "0.0"{
            averageRating = "N/A"
        }
        showLabel.text = "\(show.name)\nRating: \(averageRating)"
    }
}
