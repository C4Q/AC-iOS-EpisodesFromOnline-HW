//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController, UITableViewDelegate, UITableViewDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsSearchBar.delegate = self
    }
    
    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    @IBOutlet weak var showsTableView: UITableView!
    
    var televisionShows: [TVShows] = [] {
        didSet {
            self.showsTableView.reloadData()
        }
    }
    
    func loadData() {
        let url = ""
        let completion: ([TVShows]) -> Void = {(onlineTVShow: [TVShows] in
                self.televisionShows = onlineTVShow
            )}
    }
    
    var searchTerm = "" {
        didSet {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        televisionShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let televisionContent = self.televisionShows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowSearch", for: indexPath)
        return cell
    }
    
}
