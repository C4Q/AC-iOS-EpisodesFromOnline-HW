//
//  DetailedViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var seasonAndEpisodeNumberLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var largeImageView: UIImageView!
    
    var anEpisode: EpisodeStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        episodeNameLabel.text = "Episode Unavailable"
        seasonAndEpisodeNumberLabel.text = "Data Unavailable"
        descriptionTextView.text = "Summary Unavailable"
        
        guard let anEpisode = anEpisode else {return}
        
        episodeNameLabel.text = "Name: \(anEpisode.name ?? "TBA")"
        seasonAndEpisodeNumberLabel.text = "Season: \(anEpisode.season ?? 0) / Episode: \(anEpisode.number ?? 0)"
        descriptionTextView.text = anEpisode.summary?.html2String
        largeImageView.image = nil
        
        //PUT IMAGE API HERE
        if let urlStr = anEpisode.image?.original {
            spinner.startAnimating()
            spinner.isHidden = false
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.largeImageView.image = onlineImage
                
            }
            ImageAPIClient.manager.getImage(from: urlStr,
                                            completionHandler: setImageToOnlineImage,
                                            errorHandler: {print($0)})
            spinner.stopAnimating()
            spinner.isHidden = true
            
        } else {
            spinner.isHidden = true
            largeImageView.image = #imageLiteral(resourceName: "defaultTVImage")
        }
    }

}

//This extension turns HTML String into a regular String
//https://stackoverflow.com/questions/28124119/convert-html-to-plain-text-in-swift
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
