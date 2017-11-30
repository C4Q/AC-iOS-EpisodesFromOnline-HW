//
//  ViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q  on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {

    
    var searchTerm: String? {
        didSet {
            showSearchEndpoint = "http://api.tvmaze.com/search/shows?q=\(searchTerm!)"
        }
    }
    
    var showSearchEndpoint: String? {
        didSet {
            tableViewState = .loading
            SearchAPIClient.manager.getSearchResults(from: showSearchEndpoint!,
                                                     completionHandler: {self.searchResults = $0
                                                                        self.tableViewState = .complete},
                                                     errorHandler: {print($0)})
        }
    }
    
    var searchResults: [SearchResult]? {
        didSet {
            searchTableView.reloadData()
        }
    }
    
    
    var tableViewState: NetworkHelper.State? {
        didSet {
            guard let state = tableViewState else { return }
            switch state {
            case .loading:
                activityIndicator.startAnimating()
            case .complete:
                activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.dataSource = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpisodeSegue" {
            let destination = segue.destination as! EpisodeViewController
            let selectedCell = sender as! UITableViewCell
            let index = (searchTableView.indexPath(for: selectedCell)?.row)!
            destination.episodeEndpoint = "\((searchResults?[index].show.links.currentEpisode.href)!)/episodes"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Single")
    }

}

// MARK: Table View Data Source
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let index = indexPath.row
        guard let show = searchResults?[index].show else { return cell }
        
        
        
        cell.textLabel?.text = show.name
        cell.detailTextLabel?.text = show.rating.average?.description ?? "No Rating"
        
        // MARK: - Downloads images async
        if let albumURL = URL(string: show.image?.medium ?? "noImage") {
            
            // doing work on a background thread
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: albumURL) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                } else {
                    cell.imageView?.image = UIImage(named: "noImage")
                    cell.setNeedsLayout()
                }
                
            }
        }
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard !(searchBar.text?.isEmpty)! else { return }
//        searchTerm = searchBar.text
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        searchTerm = searchText
    }
}
