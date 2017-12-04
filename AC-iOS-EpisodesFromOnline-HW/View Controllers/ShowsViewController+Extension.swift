//
//  ShowViewController+Extension.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

extension ShowsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - TableView Datasource Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as? ShowsTableViewCell {
            cell.nameLabel.text = show.show.name
            if let raiting = show.show.rating.average {
                cell.ratingLabel.text = "Raiting: \(raiting)"
            } else {
                cell.ratingLabel.text = "Raiting: N/A"
            }
            if let image = show.show.image, let urlImage = image.medium {
                let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                    cell.showImageView.image = onlineImage
                    cell.setNeedsLayout() //Makes the image load as soon as it's ready
                }
                let errorHandler: (Error) -> Void = {(error: Error) in
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                ImageAPIClient.manager.getImage(from: urlImage,
                                                completionHandler: completion,
                                                errorHandler: errorHandler)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: - Searchbar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    //MARK: - Segue to Episodes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let show = shows[showsTableView.indexPathForSelectedRow!.row]
        if let EpisodeDVC = segue.destination as? EpisodesViewController {
            EpisodeDVC.show = show.show
        }
    }
}
