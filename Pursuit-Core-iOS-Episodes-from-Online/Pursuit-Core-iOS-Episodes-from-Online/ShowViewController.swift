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
    
    var filteredShows: [Show] {
        get {
            guard let searchString = searchString else { return shows }
            
            guard searchString != "" else { return [Show]()}
            
            return Show.getFilteredResults(arr: shows, searchText: searchString)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            loadData()
            self.showTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showSearchBar.delegate = self
    }
    
    func configureTableView() {
        showTableView.dataSource = self
        showTableView.delegate = self
        showTableView.rowHeight = 200
        showTableView.tableFooterView = UIView()
    }
    
    private func loadData() {
        
        ShowAPIHelper.shared.getShows() { (result) in
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
        return filteredShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! ShowsTableViewCell
        
        let show = filteredShows[indexPath.row]
        cell.nameLabel.text = show.name
        cell.ratingLabel.text = show.rating.average?.description
        
        ImageHelper.shared.getImage(urlStr: show.image.original) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        cell.showImage.image = imageFromOnline
                    }
                }
            }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "showSegue":
            
            guard let indexPath = showTableView.indexPathForSelectedRow,
                let destination = segue.destination as? EpisodesViewController else { return }
            let showToPassOver = shows[indexPath.row]
            destination.show = showToPassOver

            
            EpisodesAPIHelper.shared.getEpisodes(id: showToPassOver.id) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let episodesFromJSON):
                        destination.episodes = episodesFromJSON
                    }
                }
            }
            
        default:
            fatalError("unexpected segue identifies")
        }
        
    }
    
    
}
extension ViewController: UITableViewDelegate{}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}

