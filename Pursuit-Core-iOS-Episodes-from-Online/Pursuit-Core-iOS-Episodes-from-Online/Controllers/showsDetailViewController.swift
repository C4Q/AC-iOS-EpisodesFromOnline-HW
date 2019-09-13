//
//  showsDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.


import UIKit

class showsDetailViewController: UIViewController {

    var currentEpisode: Episode!
    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var summaryText: UITextView!
    
    
   private func loadEpisodeImage () {
        if let episodeImage = currentEpisode.image?.original {
            ImageHelper.shared.fetchImage(urlString: episodeImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                      self.episodeImage.image = imageFromOnline
                        
                    }
                }
            }
        } else {
            self.episodeImage.image = UIImage(named: "noImage")
        }
    }
    
    private func setLabelText() {
        nameLabel.text = currentEpisode.name
        summaryText.text = currentEpisode.summary
        numberLabel.text = "E:\(currentEpisode.number)"
        seasonLabel.text = "S:\(currentEpisode.season)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()

        loadEpisodeImage()
    }
   
}
