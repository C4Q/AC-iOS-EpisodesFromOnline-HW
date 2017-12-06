//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    @IBOutlet weak var showsTableView: UITableView!
    
    var televisionShows: [TVShows] = [] {
        didSet {
            self.showsTableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsSearchBar.delegate = self
    }
    
    func loadData() {
    //API goes here
        let url = "http://api.tvmaze.com/search/shows?q=\(searchTerm.replacingOccurrences(of: " ", with: "%20"))"
        let completion: ([TVShows]) -> Void = {(onlineTVShow: [TVShows]) in
            self.televisionShows = onlineTVShow
        }
            TVAPIClient.manager.getTVShows(from: url,
            completionHandler: completion,
            errorHandler: {print($0)})
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? "" //prevents nils
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        self.searchTerm = searchBarText
    }
    
    func configureCell(cell: ShowTableViewCell, series: TVShows) {
        cell.showTitleLabel.text = series.show.name
        if series.show.rating!.average != nil {
            cell.showRatingLabel.text = "Rating: \(series.show.rating!.average!)"
        } else {
            cell.showRatingLabel.text = "Rating: Non-existent"
        }
        
        //Image API Here
        
        if let urlStr = series.show.image?.medium {
            cell.showSpinner.isHidden = false
            cell.showSpinner.startAnimating()
            let setImageToOnlineImage: (UIImage) -> Void =
                {(onlineImage: UIImage) in
                cell.showImageView.image = onlineImage
                cell.setNeedsLayout()
                cell.showSpinner.isHidden = true
                cell.showSpinner.stopAnimating()
                }
            ImageAPIClient.manager.getImage (from: urlStr,
                                             completionHandler: setImageToOnlineImage,
                                             errorHandler: {print($0)})
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return televisionShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let televisionContent = televisionShows[indexPath.row]
        guard let cell = showsTableView.dequeueReusableCell(withIdentifier: "ShowSearch", for: indexPath) as? ShowTableViewCell else
        {return UITableViewCell()}
        configureCell(cell: cell, series: televisionContent)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let selectedRow = self.showsTableView.indexPathForSelectedRow!.row
            let selectedSeries = self.televisionShows[selectedRow]
            destination.showID = selectedSeries.show.id.description
        }
    }
    
}
