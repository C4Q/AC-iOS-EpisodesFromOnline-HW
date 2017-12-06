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
                                                     errorHandler: {print($0)
                                                                    self.tableViewState = .incomplete})
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
                activityIndicator.color = .gray
            case .incomplete:
                activityIndicator.color = .red
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            //Sets location of spinner to top right spot in nav bar
            let barButton = UIBarButtonItem(customView: activityIndicator)
            self.navigationItem.setRightBarButton(barButton, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewState = .complete
    }
    
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
            activityIndicator.startAnimating()
            let destination = segue.destination as! EpisodeViewController
            let selectedCell = sender as! SearchTableViewCell
            let index = (searchTableView.indexPath(for: selectedCell)?.row)!
            destination.episodeEndpoint = "\((searchResults?[index].show.links.currentEpisode.href)!)/episodes"
            destination.showName = (searchResults?[index].show.name)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        self.searchTableView.backgroundColor = ProjectColor.backroundGray

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: Table View Data Source
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? -1
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchTableViewCell
        let index = indexPath.row
        guard let show = searchResults?[index].show else { return cell }
    
        cell.nameLabel.text = show.name
        cell.ratingLabel.text = {
            cell.ratingLabel.textColor = ProjectColor.niceYellow
            if let rating = show.rating.average {
                let stars = String(repeating: "★", count: Int(rating)) + String(repeating: "✩", count: Int(10 - rating))
                return stars
            } else {
                return "No Rating"
            }
        }()
        
        ImageDownloader.manager.getImage(from: show.image?.medium ?? "noImage",
                                         completionHandler: {self.tableViewState = .complete
                                                            cell.searchImageView.image = UIImage(data: $0)
                                                            cell.setNeedsLayout()},
                                        errorHandler: {self.tableViewState = .incomplete
                                                        cell.searchImageView.image = UIImage(named: "noImage")
                                                        cell.setNeedsLayout()})
        
        return cell
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        searchTerm = searchText
    }
}
