//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by albert coelho oliveira on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var episode: Episodes?
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var episodeDetail: UILabel!
    
    @IBOutlet weak var episodeNum: UILabel!
    
    @IBOutlet weak var episodeDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabel()
        loadImage()
    }
    func loadLabel(){
        episodeDetail.text = episode?.name
        episodeNum.text = episode?.episodeFormat
        episodeDescription.text = episode?.fixedSummary
    }
    func loadImage(){
        if let url = episode?.image?.original {
        ImageHelper.shared.fetchImage(urlString: url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.detailImage.image = image
                }
            }
        }
        
        }}
}
