//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    
    var shows = [Show]() {
        didSet {
            showTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData(str: "jane")
        showSearchBar.delegate = self
    }
    
    func configureTableView() {
        showTableView.dataSource = self
        showTableView.delegate = self
        showTableView.rowHeight = 100
        showTableView.tableFooterView = UIView()
    }
    
    private func loadData(str:String?) {
        
        ShowAPIHelper.shared.getShows(str:str) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showsFromJSON):
                    self.shows = showsFromJSON
                }
            }
        }
    }
    

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! ShowsTableViewCell
        
        let show = shows[indexPath.row]
        cell.nameLabel.text = show.name
        cell.ratingLabel.text = show.rating.average?.description
        
        if let showImage = show.image.original {
            ImageHelper.shared.getImage(urlStr: showImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        cell.showImage.image = imageFromOnline
                    }
                }
            }
        } else {
            cell.showImage.image = UIImage(named: "noImage")
        }
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate{}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(str: searchText)
    }
}

