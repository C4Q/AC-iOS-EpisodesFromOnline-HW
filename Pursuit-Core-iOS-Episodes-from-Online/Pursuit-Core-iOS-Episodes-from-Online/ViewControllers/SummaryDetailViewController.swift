//
//  SummaryDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Sam Roman on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SummaryDetailViewController: UIViewController {
    
    
    var selectedEpisode: Episode? {
        didSet {
            ImageHelper.shared.fetchImage(urlString: selectedEpisode?.image?.original ?? "") { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print(error)
                            print("could not load image")
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                            self.summaryImage.image = UIImage(named: "placeHolder")
                        case .success(let data):
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                            self.summaryImage.image = data
                        }
                    }
                }
        }
        }
    
    
    @IBOutlet weak var summaryImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    
    @IBOutlet weak var summaryTextField: UITextView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func loadImage(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        ImageHelper.shared.fetchImage(urlString: selectedEpisode?.image?.original ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("could not load image due to \(error)")
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.summaryImage.image = UIImage(named: "placeHolder")
                case .success(let data):
                   self.activityIndicator.isHidden = true
                   self.activityIndicator.stopAnimating()
                   self.summaryImage.image = data
                }
            }
        }
    }
    
    func loadLabels(){
        nameLabel.text = selectedEpisode!.name
        seasonEpisodeLabel.text = selectedEpisode!.seasonAndEpisode
        summaryTextField.text = selectedEpisode!.updatedSummary
    }
    
    override func viewDidLoad() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        loadLabels()
        super.viewDidLoad()

    }
    


}
