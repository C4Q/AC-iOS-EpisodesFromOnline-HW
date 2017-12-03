//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    var selectedEpisode: Episode?
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    func loadData() {
        nameLabel.text = selectedEpisode?.name
        episodeLabel.text = "Season:\(selectedEpisode?.season?.description ?? "N/A")  Episode:\(selectedEpisode?.number?.description ?? "N/A")"
        summaryTextView.text = selectedEpisode?.summary
        guard let imageURL = selectedEpisode?.image?.original else {return}
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.episodeImageView.image = onlineImage
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: {print($0)})
    }

}
