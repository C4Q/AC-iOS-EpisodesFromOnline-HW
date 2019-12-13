//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData(searchQuery: "")
        delegateOrDataSourceMethods()
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
    
    func delegateOrDataSourceMethods(){
        tableView.dataSource = self
        searchBar.delegate = self
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
        cell.configureCell(for: show)
        
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

