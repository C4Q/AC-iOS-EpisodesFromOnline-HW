//
//  EpisodeDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/6/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var chosenEpisode: Episode!
    var chosenEpisodeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = chosenEpisodeImage
        self.titleLabel.text = chosenEpisode.name
        self.seasonLabel.text = "Season: \(chosenEpisode.season)"
        self.episodeLabel.text = "Episode: \(chosenEpisode.number)"
        self.textView.text = chosenEpisode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
