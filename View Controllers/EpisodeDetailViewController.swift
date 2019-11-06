//
//  EpisodeDetailViewController.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var selectedEpisode: Episode!
    var theImageFromThePreviousControllerSoNoMoreAPICalls: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }
    
    func loadViews() {
        self.episodeImage.image = theImageFromThePreviousControllerSoNoMoreAPICalls
        self.titleLabel.text = selectedEpisode.name
        self.seasonLabel.text = "Season: \(selectedEpisode.season)"
        self.episodeNumberLabel.text = "Episode: \(selectedEpisode.number)"
        self.summaryTextView.text = selectedEpisode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? ""
    }
}
