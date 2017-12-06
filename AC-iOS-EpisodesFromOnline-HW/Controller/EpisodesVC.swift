//  EpisodesVC.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class EpisodesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

	//MARK: - Outlets
	@IBOutlet weak var episodesTableView: UITableView!

	//MARK: - Variables/Constants
	var show: Show!
	var episodes = [Episode]() {
		didSet {
			episodesTableView.reloadData()
		}
	}

	//MARKL - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		episodesTableView.dataSource = self
		episodesTableView.delegate = self
		self.navigationItem.title = show.name
		loadEpisodes()
	}

	func loadEpisodes() {
		let urlStr = "https://api.tvmaze.com/shows/\(show.id)/episodes"
		let setEpisodes: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
			self.episodes = onlineEpisodes
		}
		let printErrors = {(error: Error) in
			print(error)
		}
		EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: setEpisodes, errorHandler: printErrors)
	}

	//MARK: - TableView Datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return episodes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {return UITableViewCell()}
		let episode = episodes[indexPath.row]
		cell.titleLabel?.text = "Title: \(episode.name)"
		cell.seasonEpisodeLabel?.text = "S: \(episode.season), E: \(episode.number)"
		cell.episodeViewImage?.image = nil
		cell.imageSpinner.isHidden = false
		cell.imageSpinner.startAnimating()
		guard let imageURL = episode.image?.medium else {return cell}
		let setImage: (UIImage)->Void = {(onlineImage: UIImage) in
			cell.episodeViewImage?.image = onlineImage
			cell.setNeedsLayout()
			DispatchQueue.main.async {
				cell.imageSpinner.isHidden = true
				cell.imageSpinner.stopAnimating()
			}
		}
		ImageAPIClient.manager.getImage(from: imageURL,
																completionHandler: setImage,
																errorHandler: {print($0)})
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? EpisodesDVC {
			let row = episodesTableView.indexPathForSelectedRow!.row
			let selectedEpisode = self.episodes[row]
			destination.episode = selectedEpisode
		}
	}

}

