//
//  SeriesTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seriesImage.image = nil
    }

    // MARK: Helper Methods
    func setUp(using series: Series) {
        NetworkHelper.shared.getImage(using: series.show?.image?.original ?? "") { result in
            switch result{
            case .failure(let netError):
                print("Encountered Error in getting Series Image: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self.seriesImage.image = image
                    self.seriesNameLabel.text = series.show?.name ?? "Unknown Show"
                }
            }
        }
    }
}
