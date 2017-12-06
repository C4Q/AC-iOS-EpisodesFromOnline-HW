//
//  ShowListViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {
    
    @IBOutlet weak var showsTableView: UITableView!
    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    var shows: [Show] = []
    var searchTerm: String = "" {
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
        ShowAPIClient.manager.getShows(
            from: searchTerm,
            completionHandler: { (onlineShows) in
                self.shows = onlineShows
                self.showsTableView.reloadData()
        },
            errorHandler: { (appError) in
                let alertController = UIAlertController(title: "ERROR", message: "Search could not find any results:\n\(appError)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let destinationVC = segue.destination as? EpisodeListViewController,
            let selectedCell = sender as? ShowsTableViewCell,
            let indexPath = showsTableView.indexPath(for: selectedCell) {
            
            let currentShow = shows[indexPath.row]
            destinationVC.show = currentShow
        }
    }
    
}
//Table View Methods
extension ShowListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let showCell = tableView.cellForRow(at: indexPath) as? ShowsTableViewCell {
            performSegue(withIdentifier: "episodeSegue", sender: showCell)
        }
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)
        let currentShow = shows[indexPath.row]
        
        if let showCell = cell as? ShowsTableViewCell {
            
            showCell.titleLabel.text = currentShow.name
            showCell.showImageView.image = nil
            
            guard let image = currentShow.image else {
                showCell.showImageView.image = #imageLiteral(resourceName: "noImage")
                return showCell
            }
            
            //show image
            ImagesAPIClient.manager.getImage(
                from: image.mediumURL,
                completionHandler: { (onlineImage) in
                    showCell.showImageView.image = onlineImage
                    showCell.setNeedsLayout()
            },
                errorHandler: {print($0)})
            
            return showCell
        }
        
        return cell
    }
}

//Search Bar Methods
extension ShowListViewController: UISearchBarDelegate {
    
    //Delegate Methods - NOTE: using this delegate method instead of when search text changes to prevent rate limiting from API
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        searchTerm = searchText
    }
}
