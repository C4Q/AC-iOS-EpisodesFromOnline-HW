//
//  DetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var episode: Episode?
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = ProjectColor.niceYellow
            nameLabel.text = episode?.name
            
        }
    }
    
    @IBOutlet weak var episodeLabel: UILabel! {
        didSet {
            episodeLabel.text = "Season: \(episode?.season.description ?? "")    Episode: \(episode?.number.description ?? "")"
        }
    }
    
    @IBOutlet weak var summaryText: UITextView! {
        didSet {
            summaryText.backgroundColor = ProjectColor.backroundGray
            summaryText.textColor = ProjectColor.niceYellow
            if let summary = episode?.summary {
                //Removes html tags
                summaryText.text = summary.replacingOccurrences(of: "<[^>]*>", with: "", options: .regularExpression)
            } else {
                summaryText.text = "No Summary!"
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            if let imageURL = episode?.image?.original,
                let albumURL = URL(string: imageURL) {
                // doing work on a background thread
                DispatchQueue.global().sync {
                    if let data = try? Data.init(contentsOf: albumURL) {
                        // go back to main thread to update UI
                        DispatchQueue.main.async {
                            self.imageView?.image = UIImage(data: data)
                        }
                    }
                }
            } else {
                self.imageView?.image = UIImage(named: "noImage")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = ProjectColor.backroundGray
        self.view.backgroundColor = ProjectColor.backroundGray
        
        episodeLabel.numberOfLines = 0
        episodeLabel.lineBreakMode = .byWordWrapping
        
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
