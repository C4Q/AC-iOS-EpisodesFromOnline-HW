//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TVTableview: UITableView!
    
    @IBOutlet weak var searchBarOut: UISearchBar!
    
    
    func loadSearch(str: String){
        SearchAPIClient.getResults(searchTerm: str) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("")
                case .success(let results):
                self.searchResults = results
                }
            }
        }
    }
    

    var searchResults = [SearchResult]() {
        didSet {
            TVTableview.reloadData()
            
        }
    }

  

    
    //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVTableview.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        if searchResults.count != 0 {
        let result = searchResults[indexPath.row].show
        cell.nameLabel.text = result.name
            if let rating = result.rating.average {
                cell.ratingLabel.text = "Rating: \(rating)"
            }
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            ImageHelper.shared.fetchImage(urlString: result.image?.medium ?? "") { (result) in
                DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                print(error)
                cell.activityIndicator.stopAnimating()
                cell.cellImage.image = UIImage(named: "placeHolder")
                case .success(let data):
                cell.activityIndicator.stopAnimating()
                cell.cellImage.image = data
                    }
                }
            }
    }
    return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeSegue" {
            let destination = segue.destination as! EpisodesDetailViewController
            let selectedCell = sender as! SearchTableViewCell
            let index = (TVTableview.indexPath(for: selectedCell)?.row)!
            destination.endPoint = searchResults[index].show
        }
    }
    
    

    override func viewDidLoad() {
        TVTableview.delegate = self
        TVTableview.dataSource = self
        searchBarOut.delegate = self
//        self.activityOutlet.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}






extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchTerm = searchBar.text ?? ""
        searchTerm = searchTerm.lowercased().replacingOccurrences(of: " ", with: "-")
        loadSearch(str: searchTerm)
        print(searchTerm)
    }
}
