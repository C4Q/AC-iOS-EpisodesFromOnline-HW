//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class ShowsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View Overides
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //self requires to the ShowsViewController
        tableView.delegate = self //self requires to the ShowsViewController
        searchBar.delegate = self //self requires to the ShowsViewController
        loadShows() //loaded shows on startup, based on searchTerm == a, to avoid blank tableview
    }

    //MARK: Variables and Constants
    var shows = [Show](){ //empty array of type Show
        didSet{
            tableView.reloadData() //reload the tableview rows when the shows change based on the search term
        }
    }
    var searchTerm = "a" { //set to a to have a default set of shows on staartup, instead of a blank tableView
        didSet{
            loadShows() //reload the shows whenever the search term changes
        }
    }
    
    //MARK: Functions
    func loadShows() {
        //part #1 - url - get the shows from api based on the search term
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"

        //part #2 - completion (get the data) computed proerty set by a closure
        let setShows = { (onlineShows: [Show]) in
            self.shows = onlineShows
        }
        
        //part #3 - errorhandler
        let printErrors = {(error: Error) in
            print(error)
        }
        
        //This whole function is just in order to use this. All the info above is just the info passed into the ShowAPIClient.manager.getShows
       ShowAPIClient.manager.getShows(withURL: urlStr, completionHandler: setShows, errorHandler: printErrors)
    }
    
    //MARK: Searchbar Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //when user press enter it updates
        //self.searchTerm = (searchBar.text)! //doesnt allow for spaces
        //allows us to use spaces in our search (turning into an array separated by spaces, then its joining the array back into a string
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { //as user types it updates
        //self.searchTerm = searchText //doesnt allow spaces
        self.searchTerm = (searchText.components(separatedBy: " ").joined(separator: "%20")) ////allows us to use spaces in our search (turning into an array separated by spaces, then its joining the array back into a string
    }
    
    //MARK: TableView DataSource - required Datasource methods
    //Default number of Sections is 1.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Sets the number of Rows in each section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shows.count
    }
    //This sets the information for EACH row - (for each show)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //part #1 - define the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        //part #2 - getting the show info from the shows array for each row
        let show = shows[indexPath.row]
        
        //part #3 - display the show info for each cell
        cell.showNameLabel?.text = show.name
        cell.showRatingLabel?.text = "Rating: \(show.rating?.average ?? 0.0)" //use the nil coalescing operator to unwrap the optional value and provide a default for nil
    
        //display Image for cell - for each show        
        //Sets the image using ImageAPIClient - needs url, completion (setImage)
        guard let imageURL = (show.image?.original ?? show.image?.medium) else {return cell}
        let setImage: (UIImage)->Void = { (onlineImage: UIImage) in
            cell.showImageView?.image = onlineImage //set the image url
            cell.setNeedsLayout() //updates image to ensure its correct while scrolling
        }
        let printErrors = {(error: Error) in print(error)}
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: setImage, errorHandler: printErrors)
        
        return cell
    }
    
    //MARK: TableView Delegate
    //setting the height for each row programmatically
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 //height of 150
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //part #1 - create the destination
        guard let EpisodeViewController = segue.destination as? EpisodesViewController else {return}
        //part #2 - get the row that was selected in the tableView
        let selectedRow = tableView.indexPathForSelectedRow!.row //returns an Int
        
        //part #3 - get the selected Show from the row info above using the shows variable with subscript syntax
        let selectedShow = shows[selectedRow] //sunscripting the array of shows to get the seletect show
        EpisodeViewController.show = selectedShow
        
    }


}
