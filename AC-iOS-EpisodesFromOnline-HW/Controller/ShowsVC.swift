//  ShowsVC.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

//displays a list of shows [Show] to the user, based on search criteria
class ShowsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

	//MARK: - Outlets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		searchBar.delegate = self
	}

	//MARK - Variables
	var shows = [Show]() {
		didSet {
			self.tableView.reloadData()
		}
	}
	var searchTerm = "" {
		didSet{
			loadShows(named: searchTerm)
		}
	}


	//MARK: - functions
	func loadShows(named str: String){
		let setShows: ([Show])->Void = {(onlineShows: [Show]) in
			self.shows = onlineShows
		}
		let printErrors = {(error: Error) in
			print(error)
		}
		ShowAPIClient.manager.getShows(named: str, completionHandler: setShows, errorHandler: printErrors)
	}


	//MARK: - Search Bar Delegate Methods
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchTerm = searchBar.text ?? ""
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.searchTerm = searchText
	}

	//MARK: - TableView Datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.shows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = self.tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell {
			let show = self.shows[indexPath.row]
			cell.showNameLabel?.text = "Show: \(show.name)"
			cell.ratingLabel?.text = "Rating: \(show.rating)"
			//MARK: - Load Image
			cell.imageView?.image = nil //Gets rid of flickering
			let imageUrlStr = show.image.original
			let setImage: (UIImage)->Void = {(onlineImage: UIImage) in
				cell.imageView?.image = onlineImage
				cell.setNeedsLayout() //Makes the image load as soon as it's ready
			}
			ImageAPIClient.manager.getImage(from: imageUrlStr,
																			completionHandler: setImage,
																			errorHandler: {print($0)})
			return cell
		}
	}

	//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	//		let cell = self.tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)
	//		if let cell = cell as? ShowCell {
	//			let show = shows[indexPath.row]
	//			cell.showNameLabel?.text = "Show: \(show.name)"
	//			cell.ratingLabel?.text = "Rating: \(show.rating)"
	//			//MARK: - Load Image
	//			cell.imageView?.image = nil //Gets rid of flickering
	//			let imageUrlStr = show.image.original
	//			let completion: (UIImage)->Void = {(onlineImage: UIImage) in
	//				cell.imageView?.image = onlineImage
	//				cell.setNeedsLayout() //Makes the image load as soon as it's ready
	//			}
	//			ImageAPIClient.manager.getImage(from: imageUrlStr,
	//																			completionHandler: completion,
	//																			errorHandler: {print($0)})
	//		}
	//		return cell
	//	}


	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let EpisodesVC = segue.destination as? EpisodesVC else { return }
		let row = tableView.indexPathForSelectedRow!.row
		let selectedShow = self.shows[row]
		EpisodesVC.show = selectedShow
	}
}
