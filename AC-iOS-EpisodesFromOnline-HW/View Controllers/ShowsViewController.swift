//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {

   
    @IBOutlet weak var showTableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var tvShows = [ShowWrapper]() {
        didSet {
            self.showTableView.reloadData()
        }
    }
    
    
    var searchTerm: String = "" {
        didSet {
            loadData()
        }
    }
    
    func loadData() {
        if searchTerm == "" { self.tvShows = []
            self.showTableView.reloadData()
            return
        }
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        ShowsAPIClient.shared.getShows(from: urlStr, completionHandler: {self.tvShows = $0}, errorHandler: {print($0)})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTableView.delegate = self
        self.showTableView.dataSource = self
        self.searchBar.delegate = self
    
    }

}


extension ShowsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.showTableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as? ShowTableViewCell else {return UITableViewCell()}
        let thisShow = self.tvShows[indexPath.row]
        cell.showNameLabel.text = thisShow.show.name
        
        cell.ratingLabel.text = (thisShow.show.rating.average?.description) ?? "no rating"
        cell.showImageView.image = nil
        
        guard let imageUrl = thisShow.show.image?.medium else {return UITableViewCell()}
        let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.showImageView.image = onlineImage
            cell.setNeedsLayout()
        }
        
        ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: getImage, errorHandler: {print($0)})
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EpisodesViewController {
            let selectedRow = showTableView.indexPathForSelectedRow?.row
            let selectedShow = tvShows[selectedRow!]
            destinationVC.myShow = selectedShow
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    
}











