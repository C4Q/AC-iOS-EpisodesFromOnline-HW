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
        //make sure if search term is empty the array is empty
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
        //as! makes sure each cell will be a custom tableview cell. No need for guard statements
        let cell = self.showTableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as! ShowTableViewCell
        let thisShow = self.tvShows[indexPath.row]
        cell.showNameLabel.text = thisShow.show.name
        
        //give default values in case of nil
        cell.ratingLabel.text = (thisShow.show.rating.average?.description) ?? "no rating"
        //set image to nil initially before image loads from global queue. during this time spinner should be visible
        cell.showImageView.image = nil
        cell.showSpinner.isHidden = false
        cell.showSpinner.startAnimating()
        
        
        if let imageUrl = thisShow.show.image?.medium {
        let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.showImageView.image = onlineImage
            //after image is loaded from global, spinner should go away
            cell.setNeedsLayout()
            cell.showSpinner.isHidden = true
            cell.showSpinner.stopAnimating()
        }
        
        ImageAPIClient.manager.getImage(from: imageUrl, completionHandler: getImage, errorHandler: {print($0)})
       
        } else {
            //default in case show doesnt have an image.
            cell.showImageView.image = #imageLiteral(resourceName: "noImage")
            cell.showSpinner.isHidden = true 
        }
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
        //in the url spaces are replaced with %20, needs to also work for spaces in the search bar text
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //if nothing is in the searchBar the tableView will not be populated.
        if searchText == "" {
            searchTerm = ""
        }
    }
    
    
}











