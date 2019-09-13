//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var episode: Episodes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    func setLabels() {
        
        nameLabel.text = episode.name
        seasonAndEpisodeLabel.text = episode.seasonAndEpisode
        descriptionLabel.text = episode.description 
        descriptionLabel.isEditable = false
        setImage()
    }
    
    func setImage() {
        
        if let episodeImage = episode.image {
            ImageHelper.shared.getImage(urlStr: episodeImage.original) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                    self.episodeImageView.image = imageFromOnline
                    }
                }
            }
            
        }
        
        episodeImageView.image = UIImage(named: "noImage")
    }


}
