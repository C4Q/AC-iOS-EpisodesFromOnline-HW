//
//  EpisodeDetailedViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailedViewController: UIViewController {

    var episode: Episodes!
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var seasonNumber: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeSummary: UITextView!
    
    private func displayImage() -> Void {
        if episode.image != nil {
            ImageHelper.getImage(stringUrl: episode.image!.medium) { (error, image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.episodeImage.image = image
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTitle.text = episode.name
        seasonNumber.text = String("Season: \(episode.season)")
        episodeNumber.text = String("Episdode: \(episode.number)")
        episodeSummary.text = episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        displayImage()
    }

}
