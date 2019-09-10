//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Michelle Cueva on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var episode: Episodes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = episode.name

    }
    


}
