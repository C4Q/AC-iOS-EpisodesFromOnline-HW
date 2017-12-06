//
//  ShowListViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {

    @IBOutlet weak var showsTableView: UITableView!
    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    var shows: [Show] = []
    var searchTerm: String = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.delegate = self
        showsTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        //to do
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //to do - set up passing
    }
}

//Table View Methods
extension ShowListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to do for segue
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)
        
        //to do
        
        return cell
    }
}
