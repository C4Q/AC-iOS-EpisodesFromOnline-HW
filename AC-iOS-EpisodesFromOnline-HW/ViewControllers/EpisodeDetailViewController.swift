//
//  EpisodeDetailViewControllerswift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Clint Mejia on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeSummary: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    var selectedEpisode: Episode?
    
    //MARK: - ViewDidLoad override
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let episode = selectedEpisode else { return }
        getImage()
        episodeTitle.text = episode.name
        episodeSeason.text = "Season: " + (episode.season?.description ?? "")
        episodeNumber.text = "Episode: " + (episode.number?.description ?? "")
        guard let summary = episode.summary else { episodeSummary.text = "Episode Description Unavailable."; return }
        episodeSummary.text = stripHTML(fromString: summary)
        
    }
    
    //MARK: - Functions
    func getImage(){
        guard let imageURL = selectedEpisode?.image?.original else { self.episodeImageView.image = #imageLiteral(resourceName: "Image-Coming-Soon-Placeholder"); return }
        let completion: (UIImage?) -> Void = { (onlineImage: UIImage?) in
            self.episodeImageView.image = onlineImage
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: completion, errorHandler: { print($0) })
    }
    
    // https://stackoverflow.com/a/40587513 - Convert HTML to plain text in Swift (without using NSAttributedString)
    func stripHTML(fromString rawString: String) -> String {
        let scanner: Scanner = Scanner(string: rawString)
        var text: NSString? = ""
        var convertedString = rawString
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            convertedString = convertedString.replacingOccurrences(of: "\(text!)>", with: "")
        }
        return convertedString
    }
}

