//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    
    @IBOutlet weak var detailSeasonLabel: UILabel!
    
    
    @IBOutlet weak var detailNumberLabel: UILabel!
    
    @IBOutlet weak var detailDescriptionTextView: UITextView!
    
    var episode: Episode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    func loadData() {
        guard let episode = episode else {return}
        self.detailNameLabel.text = episode.name
        self.detailSeasonLabel.text = "\(episode.season)"
        self.detailNumberLabel.text = "\(episode.number)"
        self.detailDescriptionTextView.text = episode.summary
        let imageUrlStr = episode.image.original
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.detailImageView.image = onlineImage
            self.detailImageView.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
    }
}
