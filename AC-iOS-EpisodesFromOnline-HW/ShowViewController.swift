//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [AmazeTV]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            let newString = searchTerm.replacingOccurrences(of: " ", with: "+")
            loadShows(named: newString)
        }
    }
    
    func loadShows(named str: String) {
        let setShows = {(onlineShows: [AmazeTV]) in
            self.shows = onlineShows
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        AmazeTVAPIClient.manager.getShow(from: str,
                                         completionHandler: setShows,
                                         errorHandler: printErrors)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

extension ShowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath)
        tableView.rowHeight = 200
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.text = show.show.name
        cell.detailTextLabel?.text = "Rating: \(show.show.rating.average != nil ? "\(show.show.rating.average!)" : "N/A")"
        
        guard let imageUrlStr = show.show.image?.medium else {
            cell.imageView?.image = #imageLiteral(resourceName: "noImage")
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHander: completion,
                                        errorHander: {print($0)})
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let show = shows[tableView.indexPathForSelectedRow!.row]
        if let episodeVC = segue.destination as? EpisodeViewController {
            episodeVC.show = show.show
        }
    }
}
    

extension ShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        resignFirstResponder()
    }
}
