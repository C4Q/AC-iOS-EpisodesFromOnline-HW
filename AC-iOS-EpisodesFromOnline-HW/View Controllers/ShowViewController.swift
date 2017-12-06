//
//  ShowViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowViewController: UIViewController,UISearchBarDelegate{


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
   
    var shows: [Show]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    var searchTerm: String = ""{
        didSet{
            loadNewShows()
            tableView.reloadData()
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchBar.text!
    }
    
    
    func loadNewShows(){
        let urlStr = "https://api.tvmaze.com/search/shows?q=\(searchTerm)"
        
        let completion: ([Show]) -> Void = {(onlineShows: [Show]) in
            self.shows = onlineShows
        }
        
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("Show Search: No internet connection")
            case .couldNotParseJSON:
                print("Show Search: Could Not Parse")
            case .badStatusCode:
                print("Show Search: Bad Status Code")
            case .badURL:
                print("Show Search: Bad URL")
            case .invalidJSONResponse:
                print("Show Search: Invalid JSON Response")
            case .noDataReceived:
                print("Show Search: No Data Received")
            case .notAnImage:
                print("Show Search: No Image Found")
            default:
                print("Show Search: Other error")
            }
        }
        ShowAPIClient.manager.getShows(from: urlStr, completionHandler: completion, errorHandler: errorHanlder)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
    }
    
    
}










extension ShowViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard shows?.count != nil else{return 0}
        return (shows?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath)
        let showToSet = shows![indexPath.row]
        
        if let cell = cell as? ShowTableViewCell{
            
            
            cell.showTitle.text = showToSet.show.name
            
            if showToSet.show.rating?.average != nil{
                cell.showRating.text = "Rating: " + (showToSet.show.rating?.average?.description)!} else{
                cell.showRating.text = "Rating: N/A"
            }
            cell.showImage.image = nil
            guard let imageUrlStr = showToSet.show.image?.medium else{
                cell.showImage.image = #imageLiteral(resourceName: "photo_not_available_large")
                cell.activityIndicator.stopAnimating()
                return cell
            }
            
            
            
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.showImage.image = onlineImage
                cell.setNeedsLayout()
                //Activity Indicator Stop Animation
                cell.activityIndicator.stopAnimating()
                
            }
            
            //Activity Indicator Start Animation
            cell.activityIndicator.startAnimating()
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
            return cell
        }
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeViewController {
            let selectedShow = shows![(tableView.indexPathForSelectedRow?.row)!]
            destination.shows = selectedShow
        }
    }
}
