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
                        case .success(let data):
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
    
    
    func loadImage(){
        ImageHelper.shared.fetchImage(urlString: selectedEpisode?.image?.original ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    print("could not load image")
                case .success(let data):
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
        loadLabels()
        super.viewDidLoad()

    }
    


}
