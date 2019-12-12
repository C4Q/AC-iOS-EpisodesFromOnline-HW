//
//  DetailedEpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/7/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailedEpisodeViewController: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    
    var currentEpisode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        guard let name = currentEpisode?.name, let season = currentEpisode?.season, let number = currentEpisode?.number, let description = currentEpisode?.summary else {
            return
        }
        
        if let image = currentEpisode?.image?.original{
            NetworkHelper.shared.getImage(using: image) { [weak self] result in
                switch result{
                case .failure(let netError):
                    print("Encountered Error while displaying episode image: \(netError)")
                case .success(let image):
                    DispatchQueue.main.async{
                        self?.episodeImage.image = image
                        self?.episodeNameLabel.text = name
                        self?.episodeNumberLabel.text = "Episode: \(number)"
                        self?.episodeSeasonLabel.text = "Season: \(season)"
                        self?.episodeDescription.text = description
                    }
                }
            }
        }
        
        DispatchQueue.main.async{
            self.episodeNameLabel.text = name
            self.episodeNumberLabel.text = "Episode: \(number)"
            self.episodeSeasonLabel.text = "Season: \(season)"
            self.episodeDescription.text = description
        }
        
    }

}
