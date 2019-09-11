//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchOutlet: UISearchBar!
    @IBOutlet weak var showTableOutlet: UITableView!
    
    var tvShows = [ShowWrapper]() {
        didSet {
            showTableOutlet.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            showTableOutlet.reloadData()
        }
    }
    
    var showSearchResults: [ShowWrapper] {
        get {
            guard let _ = searchString else {
                return tvShows
            }
            guard searchString != "" else {
                return tvShows
            }
            return tvShows
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showSearchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = showTableOutlet.dequeueReusableCell(withIdentifier: "showCell") as? ShowTableViewCell {
            
            let tvShow = showSearchResults[indexPath.row].show
            
            cell.showNameLabel.text = tvShow.name
            
            if let rating = tvShow.rating?.average {
            cell.ratingLabel.text = "\(rating) / 10"
            } else {
                cell.ratingLabel.text = "Rating Pending"
            }
           
            if let url = tvShow.image?.medium {
                ImageHelper.shared.getImage(urlStr: url) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let image):
                            cell.showImageOutlet.image = image
                        }
                    }
                }
            } else {
                cell.showImageOutlet.image = UIImage(named: "noImage")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodeViewController else { fatalError()}
        
        Episode.getEpisode(id: getEpisodeID() ) { (result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let episodes):
                episodeVC.episodes = episodes
            }
        }
    }
}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        loadData(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchOutlet.resignFirstResponder()
        searchString = searchOutlet.text
        loadData(query: searchString)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProtocols()
    }

    private func loadData(query: String?){
        ShowWrapper.getShow(userInput: query){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let shows):
                DispatchQueue.main.async{
                    return self.tvShows = shows
                }
            }
        }
    }
    
    private func getEpisodeID() -> Int {
        let episodeID = tvShows[showTableOutlet.indexPathForSelectedRow!.row].show.id
        return episodeID
    }
    
   private func setupProtocols() {
        searchOutlet.delegate = self
        showTableOutlet.delegate = self
        showTableOutlet.dataSource = self
        showTableOutlet.rowHeight = 150
    }
}

