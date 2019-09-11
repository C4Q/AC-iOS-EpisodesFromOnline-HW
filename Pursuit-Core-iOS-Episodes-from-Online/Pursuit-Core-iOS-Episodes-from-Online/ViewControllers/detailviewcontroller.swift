//
//  detailviewcontroller.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit


class DetailViewController:UIViewController {
  
    @IBOutlet weak var detailViewImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    var passingInfo:Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setUp() {
        nameLabel.text = passingInfo.name
        seasonLabel.text = passingInfo.seasonNameAndNumber
        if let image = passingInfo.image {
            ImageHelper.shared.fetchImage(urlImage:image.original) {
                (results) in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let gotImage):
                    DispatchQueue.main.async {
                        
                    
                    self.detailViewImageView.image = gotImage
                    }
                }
            }
    }
        if let summary = passingInfo.summary {
textViewOutlet.text = summary
        } else {
            textViewOutlet.text = "Could not load summary"
        }
}
}
