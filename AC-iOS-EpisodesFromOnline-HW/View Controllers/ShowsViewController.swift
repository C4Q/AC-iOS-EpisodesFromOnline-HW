//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var showsArr = [Shows]() {
        didSet {
            tableView.reloadData()
        }
    }

    var searchTerm = "" {
        didSet {
            loadData()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
    }

    func loadData() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let setShowsToOnlineShows: ([Shows]) -> Void = {(onlineShows: [Shows]) in
            self.showsArr = onlineShows
        }
        ShowsAPIClient.manager.getShows(from: urlStr,
                                        completionHandler:setShowsToOnlineShows,
                                        errorHandler: {print($0)})
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchBar.text!
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchTerm = searchBar.text ?? ""
//        searchBar.resignFirstResponder()
//    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            let selectedShow = showsArr[self.tableView.indexPathForSelectedRow!.row]
            destination.showSelected = selectedShow
        }
    }
}



//MARK: Table View
extension ShowsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showChosen = showsArr[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as! ShowTableViewCell
        
        //set title and rating and image to nil
        cell.showNameLabel.text = showChosen.show.name
        cell.showImageView.image = nil
        
        //set image API Client
        //Call the completion handler to load the theumbnail image from the url
        guard let imageUrlStr = showChosen.show.image?.medium else {
            //cell.showImageView.image = pic I choose
            return cell //only executes if you cant make the url
        }
        //Below the closure is being defined but its not running yet
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout() //Makes the image load as soon as it's ready
        }
        //Now we are passing the closure down. The closure above can only run if it passes all of the errors. in the api client and the network helper.
        //Api client first the network helper
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return cell
    }
    
}
