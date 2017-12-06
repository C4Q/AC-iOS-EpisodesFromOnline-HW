//  EpisodesDVC.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class EpisodesDVC: UIViewController {

	//MARK: - Outlets
	@IBOutlet weak var episodeImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var seasonLabel: UILabel!
	@IBOutlet weak var episodeLabel: UILabel!
	@IBOutlet weak var summaryLabel: UITextView!

	//MARK: - Variables
	var episode: Episode!

	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		loadEpisodeData()
	}

	//MARK: - Functions
	func loadEpisodeData(){
		titleLabel.text = "Title: \(episode.name)"
		seasonLabel.text = "Season: \(episode.season)"
		episodeLabel.text = "Episode: \(episode.number)"
		guard let imageURL = episode.image?.original else {return}
		ImageAPIClient.manager.getImage(from: imageURL,
																		completionHandler: {self.episodeImageView.image = $0},
																		errorHandler: {print($0)})

//		let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
//			self.episodeImageView.image = onlineImage
//			self.episodeImageView.setNeedsLayout()
//		}
//		ImageAPIClient.manager.getImage(from: imageURLStr,
//																		completionHandler: completion,
//																		errorHandler: {print($0)})
	}
}

