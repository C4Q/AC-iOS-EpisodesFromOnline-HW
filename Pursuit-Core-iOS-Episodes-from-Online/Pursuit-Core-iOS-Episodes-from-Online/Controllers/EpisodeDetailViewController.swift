//
//  EpisodeDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    @IBOutlet weak var episodeSummary: UITextView!
    
    // MARK: Properties
    var episode: Episode!
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Private Methods
    private func setupViews() {
        episodeName.text = episode.name
        episodeSummary.text = episode.cleanedSummary
        seasonAndEpisodeLabel.text = episode.seasonAndEpisode
        if let urlStr = episode.image?.original {
            ImageHelper.shared.fetchImage(urlImage: urlStr) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageFromOnline):
                        self.episodeImage.image = imageFromOnline
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

}
