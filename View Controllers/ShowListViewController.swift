//
//  ShowListViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var shows = [Show](){
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchTerm:String = "" {
        didSet {
            loadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData() {
        let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchTerm)"
        let completion: ([Show]) -> Void = {(onlineShow: [Show]) in
        self.shows = onlineShow
    }
    ShowAPIClient.manager.getShows(from: urlStr, completionHandler: completion, errorHandler: {print($0)})
        
    }
}


extension ShowListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Show cell", for: indexPath)
        cell.textLabel?.text = show.show.name
        return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = self.searchBar.text ?? ""
    }
}



