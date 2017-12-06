//
//  TVShowViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
/*
 TVshows -> use \(searchterm) in place of girls: http://api.tvmaze.com/search/shows?q=girls
 Show episodes: "http://api.tvmaze.com/shows/32087"
*/
class TVShowViewController: UIViewController {
    
    @IBOutlet weak var tvShowTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activitySpinner1: UIActivityIndicatorView!
    
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
        activitySpinner1.isHidden = true
        getTVShowData()
    }
    
    func getTVShowData(){
        ///TVShowAPI
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        //set completion
        let completion: ([TVShow]) -> Void = {(onlineTVShow: [TVShow]) in
            self.shows = onlineTVShow
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box: bad url
            let alertController = UIAlertController(title: "Error", message: "An error occurred: \(error)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            alertController.view.layoutIfNeeded() //avoid Snapshotting error
            self.present(alertController, animated: true, completion: nil)   
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

/// MARK: - TableView for TV Shows
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
        
        //Come back and re-factor unwrapping of ratings
        if tvShow.show.rating?.average != nil {
            tvShowCell.TVShowRating.text = "Rating: \(tvShow.show.rating!.average!) / 10.0"
        } else {
            tvShowCell.TVShowRating.text = "Rating Unavailable"
        }
        tvShowCell.TVShowImage.image = #imageLiteral(resourceName: "defaultImage") //set to default image
        
        /// MARK: - Getting Image
        //make sure you can convert the url into an image
        guard let imageUrlStr = tvShow.show.image?.medium else {return tvShowCell}
        activitySpinner1.isHidden = false
        activitySpinner1.startAnimating()
        let completion : (UIImage) -> Void = {(onlineImage: UIImage) in
            tvShowCell.imageView?.image = onlineImage
            //image loads as soon as it's ready
            tvShowCell.setNeedsLayout()
            self.activitySpinner1.isHidden = true
            self.activitySpinner1.stopAnimating()
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
        guard let tvShowSearched = searchBar.text else {return}
        
        //replacephysical spaces with representations of white space "%20" or "+"
        //https://stackoverflow.com/questions/24200888/any-way-to-replace-characters-on-swift-string
        let newSearchTerm = tvShowSearched.replacingOccurrences(of: " ", with: "%20")
        //searchBar.text?.lowercased().replacingOccurrences(of: "+", with: ""))!
        self.searchTerm = newSearchTerm
        print("The user has pressed search")
        searchBar.resignFirstResponder()
        
        //BONUS: - If user searchTerm does not match tvShow title, bring up brick wall and alert box letting them know they need to enter the correct tv show title
        
        //if number results == 0 , show alert
                if !(searchBar.text?.contains(newSearchTerm))! {
                    //set alert pop up
                    tvShowTableView.isHidden = true // works with Fragl roc but nothing else
                    let alertController = UIAlertController(title: "Error!", message: "Could not find TV show", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    alertController.addAction(okAction)
                    alertController.view.layoutIfNeeded() //avoid Snapshotting error
                    self.present(alertController, animated: true, completion: nil)
                    tvShowTableView.isHidden = false
                    tvShowTableView.reloadData()
        
                }
    }
}
