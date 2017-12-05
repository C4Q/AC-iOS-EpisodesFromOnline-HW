//  ShowsVC.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class ShowsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

	//MARK: - Outlets
	@IBOutlet weak var showsTableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		showsTableView.dataSource = self
		showsTableView.delegate = self
		searchBar.delegate = self
	}

	//MARK - Variables
	var shows = [Show]() {
		didSet {
			self.showsTableView.reloadData()
		}
	}
	var searchTerm = "" {
		didSet {
			loadShows()
		}
	}


	//MARK: - functions
	func loadShows() {
		let urlStr = "https://api.tvmaze.com/search/shows?q=\(searchTerm)"
		let completion: ([Show])->Void = {(onlineShows: [Show]) in
			self.shows = onlineShows
		}
		let errorHandler: (AppError) -> Void = {(error: AppError) in
			switch error {
			case .couldNotParseJSON(let error): print("JSONError: \(error)")
			case .noInternetConnection: print("No internet connection")
			default: print("Other error")
			}
		}
		ShowAPIClient.manager.getShows(from: urlStr,
																	 completionHandler: completion,
																	 errorHandler: errorHandler)
		//TODO - Remove - Only for testing
		for show in shows {
			print(show.name)
		}
	}


	//MARK: - Search Bar Delegate Methods
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchTerm = searchBar.text ?? ""
		searchBar.resignFirstResponder()
	}
	//	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
	//		self.searchTerm = searchText
	//	}

	//MARK: - TableView Datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.shows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.showsTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)
		if let cell = cell as? ShowCell {
			let show = shows[indexPath.row]
			cell.showNameLabel?.text = "Show: \(show.name)"
			cell.ratingLabel?.text = "Rating: \(show.rating)"
			//MARK: - Load Image
			cell.imageView?.image = nil //Gets rid of flickering
			let imageUrlStr = show.image.original
			let completion: (UIImage)->Void = {(onlineImage: UIImage) in
				cell.imageView?.image = onlineImage
				cell.setNeedsLayout() //Makes the image load as soon as it's ready
			}
			ImageAPIClient.manager.getImage(from: imageUrlStr,
																			completionHandler: completion,
																			errorHandler: {print($0)})
		}
		return cell
	}


	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let EpisodesVC = segue.destination as? EpisodesVC else { return }
		let row = showsTableView.indexPathForSelectedRow!.row
		let selectedShow = self.shows[row]
		EpisodesVC.show = selectedShow
	}
}
