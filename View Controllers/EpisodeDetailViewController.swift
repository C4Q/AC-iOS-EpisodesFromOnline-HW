//
//  EpisodeDetailViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    var episode : Episode!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var epNameLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var epNumLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //spinner.isHidden = true
        setupUI()
        loadImg()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupUI(){
        
        epNameLabel.text = episode.name
        seasonNameLabel.text = "Season:\(episode.season)"
        epNumLabel.text = "Episode: \(episode.number)"
        textView.text = "\(episode.summary!)"
    }
    
    func loadImg(){
        spinner.isHidden = false
        spinner.startAnimating()
        if let imageUrl = episode.image?.original {//safely unwrap
            let completion: (UIImage) -> Void = {(onlineImage:UIImage) in
                self.imgView?.image = onlineImage
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                //guard let url = episode.image?.original else
                
            }
                ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: completion, errorHandler: {print($0)})
            
        } else {//else if imageUrl = null
            self.imgView.image = #imageLiteral(resourceName: "unnamed")
        }
    }
}


