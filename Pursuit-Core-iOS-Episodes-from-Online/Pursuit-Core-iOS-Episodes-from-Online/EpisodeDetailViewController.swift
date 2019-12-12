//
//  EpisodeDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        titleLabel.text = episode.name
        titleLabel.numberOfLines = 0
        seasonLabel.text = "Season: \(episode.season), Episode: \(episode.number)"
        if let summary = episode.summary {
            textView.text = summary
        } else {
            textView.isHidden = true
        }
        if let image = episode.image {
            imageView.getImage(with: image.secureOriginal) { (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Error occured handling image: \(error)")
                        self.imageView.image = UIImage(systemName: "icloud.slash")
                    }
                    
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        } else {
            imageView.image = UIImage(systemName: "icloud.slash")
        }
    }

}
