//
//  DetailedEpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/7/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailedEpisodeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    
    // MARK: Properties
    var currentEpisode: Episode?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        guard let name = currentEpisode?.name, let season = currentEpisode?.season, let number = currentEpisode?.number else {
            episodeImage.image = UIImage(systemName: "film")
            episodeNameLabel.text = "Unknown"
            episodeNumberLabel.text = "Episode: Unknown"
            episodeSeasonLabel.text = "Season: Unknown"
            episodeDescription.text = ""
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
                        self?.episodeDescription.text = ""
                        if var description = self?.currentEpisode?.summary {
                            
                            if !description.isEmpty {
                                for _ in 0...2{
                                    description.remove(at: description.index(description.endIndex, offsetBy: -1))
                                    description.remove(at: description.startIndex)
                                }
                                description.remove(at: description.index(description.endIndex, offsetBy: -1))
                            }
                            
                            self?.episodeDescription.text = description
                        }
                        
                    }
                }
            }
        }
        
        DispatchQueue.main.async{
            self.episodeImage.image = UIImage(systemName: "film")
            self.episodeNameLabel.text = name
            self.episodeNumberLabel.text = "Episode: \(number)"
            self.episodeSeasonLabel.text = "Season: \(season)"
            self.episodeDescription.text = ""
            if var description = self.currentEpisode?.summary {
                
                if !description.isEmpty {
                    for _ in 0...2{
                        description.remove(at: description.index(description.endIndex, offsetBy: -1))
                        description.remove(at: description.startIndex)
                    }
                    description.remove(at: description.index(description.endIndex, offsetBy: -1))
                }
                
                self.episodeDescription.text = description
            }
        }
        
    }

}
