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
    @IBOutlet weak var ShowListImage: UIImageView!
    
    var showsList = [Shows]() {
        didSet {
            ShowsTableView.reloadData()
        }
    }
    
//    var episodesList = [Episodes]() {
//        didSet  {
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ShowsTableView.dataSource = self
        ShowsTableView.delegate = self
        searchBar.delegate = self

    }
    
    private func loadShowData() {
        let encodedSearchString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = "https://api.tvmaze.com/search/shows?q=\(encodedSearchString!)"

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
            loadShowData()
            ShowsTableView.reloadData()
        }
    }
    
    func showNotFoundAlert() {
        let alert = UIAlertController(title: "\u{1F5E3} Contact not found!", message: "Please try again", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ShowListCell = segue.destination as? SingleShowViewController else
        {fatalError("No episode found")}
        print(ShowListCell)
        guard let selectedIndexPath = ShowsTableView.indexPathForSelectedRow else {fatalError()}
        ShowListCell.showId = showsList[selectedIndexPath.row].show.id
    }

}

extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShowsTableView.dequeueReusableCell(withIdentifier: "ShowListCell")
        let singleShow = showsList[indexPath.row]
        cell?.textLabel?.text = singleShow.show.name
        
        if singleShow.show.image != nil {
            ImageHelper.getImage(stringUrl: singleShow.show.image!.medium) { (error, image) in
                if let image = image {
                    DispatchQueue.main.async {
                         cell?.imageView?.image = image
                    }
                   
                }
            }
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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


