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
    
    @IBOutlet weak var activity3: UIActivityIndicatorView!
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    var passingInfo:Episode!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityStatusON()
        setUp()
        navigationItem.title = "Episode"
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
                        self.activityStatusOFF()
                    }
                }
            }
        } else {
            detailViewImageView.image = UIImage(named: "imageLoadError")
            activityStatusOFF()
        }
        textViewOutlet.text = passingInfo.checkSummary()

}
    func activityStatusON() {
        detailViewImageView.isHidden = true
        activity3.startAnimating()
        activity3.isHidden = false
    }
    func activityStatusOFF() {
        detailViewImageView.isHidden = false
        activity3.stopAnimating()
        activity3.isHidden = true
    }
}
