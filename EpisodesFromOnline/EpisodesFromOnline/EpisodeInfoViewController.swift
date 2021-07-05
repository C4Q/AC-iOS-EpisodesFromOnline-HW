//
//  EpisodeInfoViewController.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/14/19.
//

import UIKit

class EpisodeInfoViewController: UIViewController {
    
    @IBOutlet weak var episodeSummary: UITextView!
    
    @IBOutlet weak var episodeDetailImage: UIImageView!
    
    @IBOutlet weak var episodeDetailTitleLabel: UILabel!
    
    @IBOutlet weak var episodeDetailSeasonLabel: UILabel!
    
//    var currentEpisode: EpisodeDetailInfo?
    var episodeSource : EpisodeInfo!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        loadEpisodeDetails()
        loadViews()

    }
    
//    private func loadEpisodeDetails(){
//        EpisodeInfoAPIClient.shared.getEpisodeInfo(edInt: episodeSource.id) {(result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let EpisodeDetailInfo):
//                    self.currentEpisode = EpisodeDetailInfo
//                }
//            }
//
//
//        }
//
//    }
    private func loadViews(){
//        self.episodeDetailImage = episodeSource?.image?.original
        self.episodeDetailTitleLabel.text = "Title: \(episodeSource.name)"
        self.episodeDetailSeasonLabel.text = "Season: \(episodeSource?.season.description)"
        self.episodeSummary.text = episodeSource?.summary?.description
        
        guard let imageUrl = episodeSource.image?.medium else {return}
        ImageHelper.shared.getImage(urlStr: imageUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.episodeDetailImage.image = image
                }
            }
        }
    }
    
    
}

