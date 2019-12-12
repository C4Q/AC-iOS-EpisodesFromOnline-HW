//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowTableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var endpointURL: String { "https://api.tvmaze.com/search/shows?q=\(querySearch ?? "")"
    }
    private var querySearch: String? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    var shows = [ShowWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? EpisodeTableViewController {
            destVC.showID = shows[tableView.indexPathForSelectedRow!.row].show.id
        }
    }
    
    private func loadData() {
        GenericCodingService.manager.decodeJSON([ShowWrapper].self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print("Error decoding: \(error)")
            case .success(let showsFromURL):
                self.shows = showsFromURL
            }
        }
    }
    
    private func configureViews() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension ShowTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        querySearch = searchBar.text?.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        loadData()
        searchBar.endEditing(true)
    }
}
extension ShowTableViewController: UITableViewDelegate {}

extension ShowTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Show Cell", for: indexPath) as? ShowTableViewCell else {
            fatalError("Could not create cell from identifier Show Cell")
        }
        cell.nameLabel.text = shows[indexPath.row].show.name
        if let rating = shows[indexPath.row].show.rating.average {
            cell.ratingLabel.text = String(format: "%.2f", rating)
        } else {
            cell.ratingLabel.text = ""
        }
        if #available(iOS 13.0, *) {
            if let imageString = shows[indexPath.row].show.image?.secureMedium {
                cell.showImageView.getImage(with: imageString) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.showImageView.image = image
                        }
                    }
                }
            } else {
                cell.showImageView.image = UIImage(systemName: "chart.bar")
            }
        }
        return cell
    }
}
