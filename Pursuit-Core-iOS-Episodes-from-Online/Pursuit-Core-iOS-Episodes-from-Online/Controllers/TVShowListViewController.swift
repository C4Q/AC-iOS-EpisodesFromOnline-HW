//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TVShowListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet{
            loadData()
        }
    }
    
    private func loadData() {
        var urlStr = String()
        if searchTerm.isEmpty {
            urlStr = "http://api.tvmaze.com/shows"
        } else {
            urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        }
        let setShowsToOnlineShows = {(onlineShows: [Show]) in
            self.shows = onlineShows
        }
        ShowAPIClient.manager.getShows(from: urlStr, completionHandler: setShowsToOnlineShows, errorHandler: {print($0)})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? EpisodeListViewController,
            let selectedShowIndex = tableView.indexPathForSelectedRow else { return
        }
        
        destination.chosenShow = shows[selectedShowIndex.row].id
    }
    
}

extension TVShowListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVShowTableViewCell
        let show = shows[indexPath.row]
        
        func stopActivityIndicator(){
            cell.activityIndicator.isHidden = true
            cell.activityIndicator.stopAnimating()
        }
        
        cell.nameLabel?.text = show.name
        //If no average exists, show 0
        cell.ratingLabel.text = "Rating: \(show.rating?.average ?? 0)"
        cell.showImage.image = nil
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        
        
        if let urlStr = show.image?.medium {
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.showImage.image = onlineImage
                stopActivityIndicator()
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr, completionHandler: setImageToOnlineImage, errorHandler: {print($0)})
        } else {
            stopActivityIndicator()
        }
        return cell
    }
    
}

extension TVShowListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
        searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
    
   
}
