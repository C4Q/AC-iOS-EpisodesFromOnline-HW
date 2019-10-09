//
//  DetailEpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Eric Widjaja on 10/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class detailEpisodeViewController: UIViewController {
    //MARK: -- Outlets
    
    
    @IBOutlet weak var detailEpisodeImage: UIImageView!
    
    @IBOutlet weak var detailEpisodeTitleLabel: UILabel!
    
    @IBOutlet weak var detailEpisodeSeasonLAbel: UILabel!
    
    @IBOutlet weak var detailEpisodeDescriptionText: UITextView!
    
    @IBOutlet weak var detailSpinner: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    var currentEpisode: showEpisode!
    
    //MARK: - Methods
    private func loadCurrentEpisodeImage() {
        detailSpinner.sizeToFit()
        detailSpinner.isHidden = false
        detailSpinner.startAnimating()
        
        if let currentImage = currentEpisode.image?.original {
            ImageHelper.shared.fetchImage(urlString: currentImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        self.detailEpisodeImage.image = imageFromOnline
                        self.detailSpinner.isHidden = true
                        self.detailSpinner.stopAnimating()
                    }
                }
            }
        } else { detailEpisodeImage.image = #imageLiteral(resourceName: "noImage")
            self.detailSpinner.isHidden = true
            self.detailSpinner.stopAnimating()
        }
    }
    
    private func setLabelText() {
        if let string = currentEpisode.summary {
            let summaryWithNoHTMLStuff = string.replacingOccurrences(of: "(?i)<p[^>]*>", with: "", options: .regularExpression, range: nil)
            let cleanedUpSummary = summaryWithNoHTMLStuff.replacingOccurrences(of: "</p>", with: " ")
            detailEpisodeDescriptionText = cleanedUpSummary
        } else {
            detailEpisodeDescriptionText = "No summary available"
        }
        
        detailEpisodeTitleLabel.text = currentEpisode.name
        detailEpisodeSeasonLAbel.text = "Season: \(currentEpisode.season) Episode: \(currentEpisode.number)"
        detailEpisodeDescriptionText.text = currentEpisode.summary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        loadCurrentEpisodeImage()
    }
}
