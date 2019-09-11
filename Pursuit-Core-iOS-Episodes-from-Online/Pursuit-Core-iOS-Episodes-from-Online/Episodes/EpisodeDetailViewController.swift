//
//  EpisodeDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kevin Natera on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    var episode: Episode!
    
    @IBOutlet weak var episodeImageOutlet: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        episodeNameLabel.text = episode.name
        episodeNumberLabel.text = "Season \(episode.season), Episode \(episode.number)"
        episodeTextView.text = episode.updatedSummary
        
        if let url = episode.image?.medium {
            ImageHelper.shared.getImage(urlStr: url) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        self.episodeImageOutlet.image = image
                    }
                }
            }
        } else {
            self.episodeImageOutlet.image = UIImage(named: "noImage")
        }
    }
   
 
}
