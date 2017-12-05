//
//  TVShowViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//for tvshows -> use \(searchterm) in place of girls
//http://api.tvmaze.com/search/shows?q=girls

//link to tvshow episodes
//"http://api.tvmaze.com/shows/32087"

class TVShowViewController: UIViewController {
    
    @IBOutlet weak var tvShowTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //what is powering the app
    var shows = [TVShow]() {
        didSet{
            tvShowTableView.reloadData()
        }
    }
    
    var searchTerm: String = "" {
        didSet{
            getTVShowData()
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
        ///TVShowAPI
        
        //get url string
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        //set completion
        let completion: ([TVShow]) -> Void = {(onlineTVShow: [TVShow]) in
            self.shows = onlineTVShow
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box
        }
        
        TVShowAPICLient.manager.getTVShow(from: urlStr,
                                          completionHandler: completion,
                                          errorHandler: errorHandler)
    }
    
    
    /// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController{
            // set selected row
            let selectedRow = self.tvShowTableView.indexPathForSelectedRow!.row
            //set selected show: go to specific index in the array
            let selectedEpisode = self.shows[selectedRow]
            destination.episodes = selectedEpisode.show.links.selfKeyword.href //sending url of episodes over
            print(selectedEpisode.show.name)
            
        }
    }
}



///// MARK: - TableView for TV Shows
extension TVShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvShow = shows[indexPath.row]
        
        guard let tvShowCell = tvShowTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? TVShowTableViewCell else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = tvShow.show.name
            return defaultCell}
        
        tvShowCell.layer.borderWidth = 5
        tvShowCell.layer.borderColor = UIColor.black.cgColor
        
        
        ///MARK: - for custom cells, textLabel should be whatever you set that specific label to be
        tvShowCell.TVShowTitle.text = tvShow.show.name
        
        
        //FIND MORE ELEGANT WAY TO CHECK FOR RATING NILS
        if tvShow.show.rating?.average != nil {
            tvShowCell.TVShowRating.text = "Rating: \(tvShow.show.rating!.average!) / 10.0"
        } else {
            tvShowCell.TVShowRating.text = "Rating Unavailable"
        }
        
        //setting default image
        tvShowCell.TVShowImage.image = #imageLiteral(resourceName: "defaultImage") //set to default image
        
        /// MARK: - Getting Image
        //make sure you can conver the url into an image
        guard let imageUrlStr = tvShow.show.image?.medium else {return tvShowCell}
        
        let completion : (UIImage) -> Void = {(onlineImage: UIImage) in
            tvShowCell.imageView?.image = onlineImage
            //image loads as soon as it's ready
            tvShowCell.setNeedsLayout()
        }
        ImageAPI.manager.loadImage(from: imageUrlStr,
                                   completionHandler: completion,
                                   errorHandler: {print($0)})
        return tvShowCell
    }
}

/// MARK: - SearchBar NOT searchBar Controller
extension TVShowViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? "" //Prevents nils
        print("The user has pressed search")
        searchBar.resignFirstResponder()
    }
}

///alert box code
//                        let alertController = UIAlertController(title: "Error", message: "An error occurred: \(error)", preferredStyle: UIAlertControllerStyle.alert)
//                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                        alertController.addAction(okAction)
//                        alertController.view.layoutIfNeeded() //avoid Snapshotting error
//                        self.present(alertController, animated: true, completion: nil)

///another possible way to do a segue
/*if let destination = segue.destination as? EpisodesViewController {
 // set selected row
 let selectedRow = self.tvShowTableView.indexPathForSelectedRow!.row
 //set selected show: go to specific index in the array
 let selectedEpisode = self.shows[selectedRow]
 //destination.episodes = selectedEpisode.show.links.selfKeyword.href
 
 
 var array: [Episode] = []
 let urlStr = selectedEpisode.show.links.selfKeyword.href
 ///"http://api.tvmaze.com/episodes/10820" + "/episodes"" //"http://api.tvmaze.com/shows/32087/\(episodes)"
 //set completion
 let completion: ([Episode]) -> Void = {(onlineEpisode: [Episode]) in
 array = onlineEpisode
 }
 //set errorHandler
 let errorHandler: (Error) -> Void = {(error: Error) in
 }
 //call EpisodesAPIClient
 EpisodeAPIClient.manager.getEpisode(from: urlStr,
 completetionHandler: completion,
 errorHandler: errorHandler)
 destination.episodes = array//selectedEpisode.show.links.selfKeyword.href
 //destination.episode = shows[self.tableView.indexPathForSelectedRow!.row]
 }*/
