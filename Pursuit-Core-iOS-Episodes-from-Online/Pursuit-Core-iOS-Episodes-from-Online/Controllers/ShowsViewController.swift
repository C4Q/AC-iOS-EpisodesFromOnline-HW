//
//  ShowsViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var ShowsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var showsList: Show! {
        didSet {
            ShowsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ShowsTableView.dataSource = self
        ShowsTableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    private func loadData() {
        let url = "http://api.tvmaze.com/singlesearch/shows?q=\(searchString)&embed=episodes"
    
        ShowAPIHelper.shared.getShow(url: url) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let showsFromServer):
                    self.showsList = showsFromServer
                case .failure(let error) :
                    print(error)
                }
            }
        }
    }
    
    var searchString: String = "" {
        didSet {
            loadData()
            ShowsTableView.reloadData()
        }
    }
    
    func showNotFoundAlert() {
        let alert = UIAlertController(title: "\u{1F5E3} Contact not found!", message: "Please try again", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }

}

extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //showsList?.name.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = ShowsTableView.dequeueReusableCell(withIdentifier: "ShowCell")
//        cell?.textLabel?.text = showsList?.name
//        return cell!
//        
    }
    
    
}

extension ShowsViewController: UITableViewDelegate {
    
}

extension ShowsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBar.text!
    }
}
