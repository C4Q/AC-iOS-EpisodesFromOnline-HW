//  ShowsVC.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

//displays a list of shows [Show] to the user, based on search criteria
class ShowsVC: UIViewController, UITableViewDataSource, UISearchBarDelegate {

	//MARK: - Outlets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
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
//			loadShows(named: searchTerm)
			loadShows()
		}
	}


	//MARK: - functions
	func loadShows(){
		let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
		let setShows = {(onlineShows: [Show]) in
			self.shows = onlineShows
		}
		let printErrors = {(error: Error) in
			print(error)
		}
		ShowAPIClient.manager.getShows(from: urlStr, completionHandler: setShows, errorHandler: printErrors)
		//		ShowAPIClient.manager.getShows(from: urlStr, completionHandler: {self.images = $0}, errorHandler: {print($0)})
	}


	//MARK: - SearchBar
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
	}

	//MARK: - TableView Datasource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.shows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? showCell else {return UITableViewCell()}
		let show = shows[indexPath.row]
		cell.titleLabel?.text = "\(show.name)"
		cell.ratingLabel?.text = "Rating: \(show.rating?.average ?? 0.0)"

		cell.showImageView?.image = nil //stop flickering
		cell.imageSpinner.isHidden = false //show spinner while getting image
		cell.imageSpinner.startAnimating() //start animation while waiting on image
		guard let imageURL = show.image?.original else {return cell}
		let setImage: (UIImage)-> Void = {(onlineImage: UIImage) in
			cell.showImageView?.image = onlineImage
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

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? EpisodesVC {
			let row = tableView.indexPathForSelectedRow!.row
			let selectedShow = shows[row]
			destination.show = selectedShow
		}
	}
}
