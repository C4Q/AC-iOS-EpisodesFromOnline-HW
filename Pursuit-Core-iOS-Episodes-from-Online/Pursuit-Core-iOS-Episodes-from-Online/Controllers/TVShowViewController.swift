//
//  TVShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Eric Widjaja on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TVShowViewController: UIViewController {
    
    
//MARK: IBOutlets and properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var tvshow = [TVShow]() {
        didSet{
            tableView.reloadData()}
    }
    
    var filteredShows: [TVShow] {
        get {
            guard let searchString = searchString else {
                return tvshow }
            guard searchString != ""  else {
                return tvshow }
            return TVShow.getFilteredTVShows(arr: tvshow, searchString: searchString)
        }
    }
    
    
    var searchString: String? = nil { didSet { self.tableView.reloadData()} }
    
//MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showVC = segue.destination as? EpisodeViewController else { fatalError("Unexpected segue VC")}
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row was selected")}
        
        let selectedTVShow = filteredShows[selectedIndexPath.row]
        let selectedTVShowIDUrl = "http://api.tvmaze.com/shows/\(selectedTVShow.id)/episodes"
        
        showVC.currentTVShowURL = selectedTVShowIDUrl
        showVC.navigationItem.title = selectedTVShow.name
        
        
    }

    private func loadData(){
        TVShow.getTVShowData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showData):
                    self.tvshow = showData
                    self.tvshow = TVShow.getSortedArray(arr: self.tvshow)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
}

//MARK: Datasource
extension TVShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentShow = filteredShows[indexPath.row]
        let tvShowCell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as! ShowTableViewCell
        
        tvShowCell.showNameLabel.text = currentShow.name
        tvShowCell.showRatingLabel.text = "Rating: \(currentShow.rating?.average ?? 0.0)"
        ImageHelper.shared.fetchImage(urlString: currentShow.image.original) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let urlImage):
                    tvShowCell.showImage.image = urlImage
                }
            }
        }
        return tvShowCell
    }
}


//MARK: Delegate Methods
extension TVShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension TVShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
