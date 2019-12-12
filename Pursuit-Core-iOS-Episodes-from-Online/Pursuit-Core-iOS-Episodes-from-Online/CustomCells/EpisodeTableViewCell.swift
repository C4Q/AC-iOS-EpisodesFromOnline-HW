//
//  EpisodeTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    override func prepareForReuse(){
        super.prepareForReuse()
        episodeImage.image = nil
    }
    
    // MARK: Helper methods

    func setUp(using episode: Episode){
        guard let name = episode.name, let number = episode.number, let season = episode.season else {
            return
        }
        
        if let picture = episode.image?.medium {
        NetworkHelper.shared.getImage(using: picture) { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error in setting up Episode Cell: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self?.episodeImage.image = image
                    self?.episodeNameLabel.text = name
                    self?.episodeNumberLabel.text = "S\(season) : E\(number)"
                }
            }
        }
    }
        DispatchQueue.main.async{
            self.episodeNameLabel.text = name
            self.episodeNumberLabel.text = "S\(season) : E\(number)"
        }
    }
}
