//
//  ShowCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showLabel:UILabel!
    
    @IBOutlet weak var episodeImage:UIImageView!
    @IBOutlet weak var episodeLabel:UILabel!
    
    private var showURLString:String? = ""
    private var episodeURLString:String? = ""
    
    override func prepareForReuse(){
        super.prepareForReuse()
        
        //emptyOut the image View
        showImage.image = nil
        episodeImage.image = nil
    }
    
    
    func configureShowCell(for show: Show){
        self.showURLString = show.image?.medium
        guard let validImage = self.showURLString else {
            DispatchQueue.main.async {
                self.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            return
        }
        
        showImage.getImage(withEndPointURLString: validImage) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self.showURLString == validImage{
                        self.showImage.image = image
                    }
                }
            }
        }
        var averageRating = String(show.rating.average ?? 0.0)
        if averageRating == "0.0"{
            averageRating = "N/A"
        }
        showLabel.text = "\(show.name)\nRating: \(averageRating)"
    }
    
    func configureEpisodeCell(for episode: Episode){
        self.episodeURLString = episode.image?.medium
        guard let validEpisodeImageStr = self.episodeURLString else { DispatchQueue.main.async {
            self.episodeImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            return
        }
        episodeImage.getImage(withEndPointURLString: validEpisodeImageStr) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.episodeImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self.episodeURLString == validEpisodeImageStr{
                        self.episodeImage.image = image
                    }
                }
            }
        }
        episodeLabel.text = "\(episode.name)\n\nS:\(episode.season) E:\(episode.episode)"
    }
}
