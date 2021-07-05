//
//  EpisodeDetailViewController.swift



import UIKit

class EpisodeDetailViewController: UIViewController {

   
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    @IBOutlet weak var detailNameLabel: UILabel!
    
    
    
    @IBOutlet weak var detailSeasonLabel: UILabel!
    
    
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    
    @IBOutlet weak var detailSummary: UITextView!
    
    
    var episodeInfo : EpisodeModel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()

        
    }
    
    private func
        loadInfo(){

            self.detailNameLabel.text = "Title: \(episodeInfo.name)"
            self.detailSeasonLabel.text = "Season: \(episodeInfo.season.description)"
        self.episodeNumberLabel.text = "Episode Numb.: \(episodeInfo.epiNumber.description)"
        self.detailSummary.text = episodeInfo.summary
            
            guard let imageUrl = episodeInfo.image?.medium else {return}
            ImageHelper.shared.getImage(urlStr: imageUrl) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        self.detailImageView.image = image
                    }
                }
            }
        }
   

}
