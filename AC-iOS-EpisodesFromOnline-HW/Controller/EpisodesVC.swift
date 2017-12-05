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
	var episodes: [Episode] = []


	//MARKL - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		episodesTableView.dataSource = self
		episodesTableView.delegate = self
		loadEpisodes()
	}

	func loadEpisodes() {
		let urlStr = "https://api.tvmaze.com/shows/\(show.id)/episodes"
		let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
			self.episodes = onlineEpisodes
		}
		EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
	}

	//MARK: - TableView Datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return episodes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.episodesTableView.dequeueReusableCell(withIdentifier: "episodesCell", for: indexPath)
		let episode = episodes[indexPath.row]
		cell.textLabel?.text = episode.name
		cell.detailTextLabel?.text = "Season: \(episode.season), Episode: \(episode.number)"
		//MARK: - Load Image
		cell.imageView?.image = nil //gets rid of the flickering.
		let imageUrlStr = episode.image.medium
		let completion: (UIImage) -> Void = {(onlineEpisodeImage: UIImage) in
			cell.imageView?.image = onlineEpisodeImage
			cell.setNeedsLayout() //invalidates current layout and reload the image data to update images
		}
		ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
		return cell
	}

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let EpisodesDVC = segue.destination as? EpisodesDVC else { return }
		let row = episodesTableView.indexPathForSelectedRow!.row
		let selectedEpisode = self.episodes[row]
		EpisodesDVC.episode = selectedEpisode
	}

}

