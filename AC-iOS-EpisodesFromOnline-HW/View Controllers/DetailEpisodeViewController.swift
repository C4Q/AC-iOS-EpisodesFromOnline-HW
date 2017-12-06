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
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
//what's powering this VC
    var detailEpisodes: Episode? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Why wont they accept a cutomized color?????
        self.view.backgroundColor = UIColor.green
        //self.view.backgroundColor = UIColor.init(hexString: "#41ebf4")
        
        activitySpinner.isHidden = true
        guard let detailEpisodes = detailEpisodes else {return}
        
        episodeSummary.text = "\(detailEpisodes.summary?.html2String ?? "No summary available")"
        episodeTitle.text = "\(detailEpisodes.name)"
        episodeNumber.text = "Episode: \(String(describing: detailEpisodes.number!))"
        seasonNumber.text = "Season: \(String(describing: detailEpisodes.season!))"
        
        if let imageUrlStr = detailEpisodes.image?.original {
            activitySpinner.isHidden = false
            activitySpinner.startAnimating()
            //set completion
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.EpisodeImage.image = onlineImage
                 print("Just set image")
                self.activitySpinner.isHidden = true
                self.activitySpinner.stopAnimating()
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

//MARK: - Getting rid of <p> tag in summaries
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


//MARK: - Converting hex -> UIColor  let gold = UIColor(hexString: "#ffe700ff")

//https://stackoverflow.com/questions/28124119/convert-html-to-plain-text-in-swift
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}




