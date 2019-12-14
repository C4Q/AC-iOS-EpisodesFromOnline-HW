//
//  EpisodeDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    @IBOutlet weak var detailEpisodeView:UIImageView!
    @IBOutlet weak var detailEpisodeNameLabel:UILabel!
    @IBOutlet weak var detailEpisodedescriptionLabel:UILabel!
    
    var passedObj: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI(){
        guard let episodeInfo = passedObj else {
            fatalError("Check prepare for segue")
        }
        
        guard let validImage = episodeInfo.image?.original else {
            DispatchQueue.main.async {
                self.detailEpisodeView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            return
        }
        
        detailEpisodeView.getImage(withEndPointURLString: validImage) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.detailEpisodeView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
                return
            case .success(let image):
                DispatchQueue.main.async {
                    self.detailEpisodeView.image = image
                }
            }
        }
        detailEpisodeNameLabel.text = "\(episodeInfo.name)\nSeason \(episodeInfo.season)\nEpisode \(episodeInfo.episode)"
        detailEpisodedescriptionLabel.text = "\(episodeInfo.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))"
    }

}
