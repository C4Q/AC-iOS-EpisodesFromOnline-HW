//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var shows = [Shows]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.resignFirstResponder()
//        tableView.backgroundColor = .black
        
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    
    func loadData() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(self.searchTerm)"
        let completion: ([Shows]) -> Void = {(onlineShows: [Shows]) in
            self.shows = onlineShows
        }
        ShowAPI.manager.getShow(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationEVC = segue.destination as? EpisodeViewController {
            destinationEVC.show = shows[self.tableView.indexPathForSelectedRow!.row].show
        }
    }

}
    // MARK: - TableView
extension ShowsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath)
        if let cell = cell as? ShowsTableViewCell {
            guard let show = show.show else {return cell}
            cell.nameLabel.text = show.name
            cell.ratingLabel.text = "Rating: \(show.rating?.average?.description ?? "None")"
            cell.showImageView?.image = nil //stop flickering
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            
            if let imageURL = show.image?.original {
                let setImage: (UIImage)-> Void = {(onlineImage: UIImage) in
                    cell.showImageView?.image = onlineImage
                    cell.setNeedsLayout()
                    cell.spinner.stopAnimating()
                    cell.spinner.isHidden = true
                }
                ImageAPIClient.manager.getImage(from: imageURL,
                                                completionHandler: setImage,
                                                errorHandler: {print($0)})
            } else {
                cell.showImageView.image = #imageLiteral(resourceName: "noImage")
                cell.spinner.isHidden = true
                cell.spinner.stopAnimating()
            }
        }
        return cell
    }
}


    // MARK: - SearchBar
extension ShowsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}
