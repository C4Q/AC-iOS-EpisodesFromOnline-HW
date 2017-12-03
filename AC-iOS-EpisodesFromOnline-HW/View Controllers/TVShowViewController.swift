//
//  TVShowViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//for tvshows -> use searchterm in place of girls
//http://api.tvmaze.com/search/shows?q=girls

//for episodes, replace the 1 with thr showID from codable
//http://api.tvmaze.com/shows/1/episodes

class TVShowViewController: UIViewController {
    
    @IBOutlet weak var tvShowTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //what is powering the app
    var shows = [TVShow]() {
        didSet{
           tvShowTableView.reloadData()
        }
    }
    
    //made so you don't have to make nil
    //var tvShow: TVShow = set no image available instead of nil
    
    var searchTerm: String = "" {
        didSet{
            getTVShowData()//reload show data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowTableView.delegate = self
        tvShowTableView.dataSource = self
        searchBar.delegate = self
        getTVShowData()
    }

    func getTVShowData(){
        //set apistring if needed
        //get url string
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        //set completion
        let completion: ([TVShow]) -> Void = {(onlineTVShow: [TVShow]) in
            self.shows = onlineTVShow
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box
            let alertController = UIAlertController(title: "Error", message: "An error occurred: \(error)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        //call TVShowApiClient
        TVShowAPICLient.manager.getTVShow(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    }
    
    
    /// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            // set selected row
            //set selected show
            destination.episode = shows[self.tableView.indexPathForselectedRow!.row]
        }
    }
}

  /// MARK: - TableView for TV Shows
extension TVShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tvShowCell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? TVShowTableViewCell else {return UITableViewCell()}
        
        let tvShow = shows[indexPath.row]
        
        //title
        tvShowCell.textLabel?.text = tvShow.show.name
        //rating
        tvShowCell.textLabel?.text = String(tvShow.show.rating)
        //image
        tvShowCell.imageView?.image = #imageLiteral(resourceName: "defaultImage") //set to default image
        guard let imageUrlStr = tvShow.show.image.medium else {return tvShowCell}
        
        let completion : (UIImage) -> Void = {(onlineImage: UIImage) in
            tvShowCell.imageView?.image = onlineImage
            //image loads as soon as it's ready
            tvShowCell.setNeedsLayout()
        }
        ImageAPI.manager.loadImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        
        return tvShowCell
    }
}

  /// MARK: - SearchBar
extension TVShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
