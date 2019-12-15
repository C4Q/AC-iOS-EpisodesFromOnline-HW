//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var shows = [Series](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    var userQuery = "" {
        didSet{
            let searchURL = "http://api.tvmaze.com/search/shows?q=\(userQuery.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Scrubs")"
            
            SeriesAPI.getSeries(using: searchURL) {[weak self] result in
                switch result{
                case .failure(let netError):
                    print("Encountered Error while searching for series: \(netError)")
                case .success(let series):
                    self?.shows = series
                }
            }
            
        }
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Series List"
        searchBar.placeholder = "Enter series title here"
    }
}

// MARK: Table View Data Source Methods
extension SeriesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? SeriesTableViewCell else {
            return UITableViewCell()
        }
        xCell.setUp(using: shows[indexPath.row])
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
}

// MARK: Table View Delegate Methods
extension SeriesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let episodesVC = newStoryboard.instantiateViewController(withIdentifier: "episodeListVC") as? EpisodeListViewController else {
            return
        }
        EpisodeAPI.getEpisodes(using: "http://api.tvmaze.com/shows/\(shows[indexPath.row].show?.id ?? 1)/episodes") { result in
            switch result{
            case .failure(let netError):
                print("Encountered Error while retrieving episodes: \(netError)")
            case .success(let showList):
                episodesVC.seriesEpisodes = showList
                DispatchQueue.main.async{
                    self.navigationController?.pushViewController(episodesVC, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: Searchbar Delegate
extension SeriesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userQuery = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
