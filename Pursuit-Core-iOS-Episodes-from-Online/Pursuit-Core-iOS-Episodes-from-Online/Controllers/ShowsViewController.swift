//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var showsSearchBar: UISearchBar!
    @IBOutlet weak var showsTableView: UITableView!
    
    // MARK: Properties
    var shows = [ShowWrapper]() {
        didSet {
            showsTableView.reloadData()
        }
    }
    var searchString: String? = nil {
        didSet {
            self.showsTableView.reloadData()
        }
    }
    var showSearchResults: [ShowWrapper] {
        get {
            guard let searchString = searchString else {
                return shows
            }
            guard searchString != "" else {
                return shows
            }
            return shows
        }
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.dataSource = self
        showsTableView.delegate = self
        showsSearchBar.delegate = self
    }
    
    // MARK: Private Methods
    private func loadData(userInput: String?) {
        ShowAPIClient.shared.getShows(userSearchTerm: userInput) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let showsFromOnline):
                    self.shows = showsFromOnline
                case .failure(let error):
                    print("its me")
                    print(error)
                }
            }
        }
    }
    
    // MARK: Navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEpisodes" {
            guard let episodeListVC = segue.destination as? EpisodesViewController else {
                fatalError()
            }
            guard let selectedIndexPath = showsTableView.indexPathForSelectedRow else {
                fatalError()
            }
            episodeListVC.show = shows[selectedIndexPath.row]
        }
    }
}

// MARK: Extensions
extension ShowsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cells = showsTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowsTableViewCell {
            cells.showNameLabel.text = shows[indexPath.row].show.name
            cells.showRatingsLabel.text = shows[indexPath.row].show.rating?.average?.description
            if let urlStr = shows[indexPath.row].show.image?.medium {
                ImageHelper.shared.fetchImage(urlImage: urlStr) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let imageFromOnline):
                            cells.showImage.image = imageFromOnline
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            return cells
        }
        return UITableViewCell()
    }
    
}

extension ShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ShowsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = showsSearchBar.text
        loadData(userInput: searchString)
    }
}
