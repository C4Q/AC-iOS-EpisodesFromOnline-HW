//
//  DetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Keshawn Swanston on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var episode: Episode!
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeNumLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.episodeName.text = episode.name
        self.seasonLabel.text = "Season: \(episode.season)"
        self.episodeNumLabel.text = "Episode: \(episode.number)"
        let newSummary = episode.summary?.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
        self.summaryTextView.text = newSummary
        if let imageStr = episode.image {
            let setImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.episodeImage.image = onlineImage
                self.episodeImage.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: imageStr.medium, completionHandler: setImage, errorHandler: {print($0)})
        } else {
            episodeImage.image = #imageLiteral(resourceName: "noImage")
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
