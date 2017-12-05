//
//  DetailEpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    @IBOutlet weak var EpisodeImage: UIImageView!
    @IBOutlet weak var episodeSummary: UITextView!
    @IBOutlet weak var seasonNumber: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeTitle: UILabel!
    
    var detailEpisodes: Episode? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailEpisodes = detailEpisodes else {return}
        
        episodeSummary.text = "\(detailEpisodes.summary?.html2String ?? "No summary available")"
        episodeTitle.text = "\(detailEpisodes.name)"
        episodeNumber.text = "Episode: \(String(describing: detailEpisodes.number!))"
        seasonNumber.text = "Season: \(String(describing: detailEpisodes.season!))"
        
        //setting default image ifno image available
        if let imageUrlStr = detailEpisodes.image?.original {
            //set completion
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.EpisodeImage.image = onlineImage
                //detailEpisodes.setNeedsLayout()
            }
            //call ImageAPIClient
            ImageAPI.manager.loadImage(from: imageUrlStr,
                                       completionHandler: completion,
                                       errorHandler: {print($0)})
        }else{
            self.EpisodeImage.image = #imageLiteral(resourceName: "defaultImage")
        }
        
        EpisodeImage.layer.borderWidth = 10
        EpisodeImage.layer.borderColor = UIColor.black.cgColor
    }
}

//https://stackoverflow.com/questions/28124119/convert-html-to-plain-text-in-swift
//getting rid of <p> tag in summary
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}




