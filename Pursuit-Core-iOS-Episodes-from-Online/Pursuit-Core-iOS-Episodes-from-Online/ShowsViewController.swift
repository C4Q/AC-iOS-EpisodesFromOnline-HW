//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var showTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show](){
        didSet{
            DispatchQueue.main.async {
                self.showTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData(searchQuery: "")
        delegateOrDataSourceMethods()
    }
    
    func delegateOrDataSourceMethods(){
        showTableView.dataSource = self
        searchBar.delegate = self
    }

    func loadData(searchQuery: String){
        TVMazeAPIClient.fetchTVShows(searchQuery: searchQuery) { [weak self] (result) in
            switch result{
            case.failure(let appError):
                DispatchQueue.main.async {
                    self?.displayAlertController(title: "ERROR", message: "\(appError)")
                }
            case .success(let shows):
                self?.shows = shows
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodeViewController, let indexPath = showTableView.indexPathForSelectedRow else {
            fatalError("failed to segue ")
        }
        
        let show = shows[indexPath.row]
        episodeVC.passedObj = show
    }
}

extension ShowsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell creation
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else { fatalError("failed to dequeCell")
        }
        
        let show = shows[indexPath.row]
        cell.configureShowCell(for: show)
        
        return cell
    }
}

extension ShowsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let query = searchBar.text else {
            print("missing text")
            return
        }
        loadData(searchQuery: query)
    }
}

