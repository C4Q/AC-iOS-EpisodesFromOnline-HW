//
//  ShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by hildy abreu on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var showTableView: UITableView!
   
    
    @IBOutlet weak var showSearchBar: UISearchBar!
    
    var shows = [ShowModel] () {
        didSet {
            showTableView.reloadData()
        }
    }
    
    var searchedShow = "" {
        didSet {
            showTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       showTableView.dataSource = self
        showTableView.delegate = self
        showSearchBar.delegate = self
//       loadData()

    }
    
    private func loadData() {
        ShowAPIClient.shared.getShow (getTitle: searchedShow) { (result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let AllInfo):
                self.shows = AllInfo
            }
            }
        }
   
}
extension ShowViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           return UITableViewCell()
       }
}
    
}
