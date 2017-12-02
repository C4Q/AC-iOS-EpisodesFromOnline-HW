//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import QuartzCore


/*TO-DO
- tv series with null as some values - Changed things to optionals.
  - Make cell height equal to image height in episode VC - Adjusted height
 - </p> in summary text view - use replacingOccurencesOf
  - how to adjust font in labels for space issues - use adjustFontSizeToWidth
 - add spinner
 - make sure empty cells don't display/showing cells stretch
 - figure out constraint errors
 - maybe add shadow to text view
 - find image for missing image urls
 - Add AppError for errorhandler
 - work on text font - label issues with long sentences
 - increase font size in episode detail view
*/
class TVShowsViewController: UIViewController {
    
    @IBOutlet weak var tvShowsTableView: UITableView!
    @IBOutlet weak var tvShowsSearchBar: UISearchBar!
    
    var TVShows = [TVSeries?]() {
        didSet {
            tvShowsTableView.reloadData()
        }
    }
    
    var searchWord = " " {
        didSet {
            loadData()
        }
    }
    
    var filteredTV = [TVSeries?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For navigation bar
        self.navigationItem.title = "TV Shows"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.black
        tvShowsTableView.delegate = self
        tvShowsTableView.dataSource = self
        tvShowsSearchBar.delegate = self
        self.navigationItem.titleView?.sizeToFit()
        tvShowsSearchBar.autocapitalizationType = .none

    }
    

    
    func loadData() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchWord)"
        let completion: ([TVSeries]) -> Void = { (onlineObject:[ TVSeries]) in
            self.TVShows = onlineObject
        }
        let errorHandler: (Error) -> Void = {(error: Error) in
            //Refactor to use App Error
            print(error)
        }
        TVShowsAPIClient.manager.getNASAObject(from: urlStr, completionHandler: completion, errorHandler: errorHandler)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesViewController {
            destination.tvSerial = TVShows[tvShowsTableView.indexPathForSelectedRow!.row]
        }
    }
}


extension TVShowsViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvShow = TVShows[indexPath.row]
        let cell = tvShowsTableView.dequeueReusableCell(withIdentifier: "TVShowsCell", for: indexPath)
        if let cell = cell as? TVShowsCell {
            cell.seriesTitleLabel?.text = tvShow?.show.name
            cell.seriesRatingLabel?.text = "Rating: \(tvShow?.show.rating?.average?.description ?? "N/A")"
            cell.seriesImageView.image = nil
            //to call image
            guard let imageStr = tvShow?.show.image?.original else { return cell }
            guard let urlStr = URL(string: imageStr) else { return cell }
            DispatchQueue.main.async {
                guard let rawImageData = try? Data(contentsOf: urlStr) else {return}
                DispatchQueue.main.async {
                    guard let onlineImage = UIImage(data: rawImageData) else {return}
                    cell.seriesImageView.image = onlineImage
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TVShows.count
    }
}


extension TVShowsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = tvShowsSearchBar.text ?? " "
        tvShowsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//    }
//
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       searchWord = searchText
        
    }
    
}

