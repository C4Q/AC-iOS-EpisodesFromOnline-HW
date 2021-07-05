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
    
    @IBOutlet weak var detailEpisodeSeasonLabel: UILabel!
    
    @IBOutlet weak var detailEpisodeDescriptionText: UITextView!
    
    @IBOutlet weak var detailSpinner: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    var selectedEpisode: showEpisode!
    
    //MARK: - Methods
    private func loadSelectedEpisodeImage() {
        detailSpinner.sizeToFit()
        detailSpinner.isHidden = false
        detailSpinner.startAnimating()
        
        if let currentImage = selectedEpisode.image?.original {
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
        } else {
            self.detailSpinner.isHidden = false
            self.detailSpinner.startAnimating()
        }
    }
    
    private func loadLabelText() {
        detailEpisodeTitleLabel.text = selectedEpisode.name
        detailEpisodeSeasonLabel.text = "Season: \(selectedEpisode.season) Episode: \(selectedEpisode.number)"
        
        if let summaryString = selectedEpisode.summary {
            let summaryWithoutGibberish = summaryString.replacingOccurrences(of: "(?i)<p[^>]*>", with: "", options: .regularExpression, range: nil)
            let cleanedSummary = summaryWithoutGibberish.replacingOccurrences(of: "</p>", with: " ")
            detailEpisodeDescriptionText.text = cleanedSummary
        } else {
            detailEpisodeDescriptionText.text = "No summary available"
        }
        

    }
    //MARK: - Call Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabelText()
        loadSelectedEpisodeImage()
    }
}
