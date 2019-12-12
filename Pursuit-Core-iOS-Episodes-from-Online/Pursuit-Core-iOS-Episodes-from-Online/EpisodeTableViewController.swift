//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showID = Int()
    
    private var endpointURL: String {
        "https://api.tvmaze.com/shows/\(showID)/episodes"
    }
    
    private var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if #available(iOS 13.0, *) {
            if let destVC = segue.destination as? EpisodeDetailViewController {
                destVC.episode = episodes[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    private func loadData() {
        GenericCodingService.manager.decodeJSON([Episode].self, with: endpointURL) { (result) in
            switch result {
            case .failure(let error):
                print("Error occurred during decoding: \(error)")
            case .success(let episodesFromAPI):
                self.episodes = episodesFromAPI
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension EpisodeTableViewController: UITableViewDelegate {}
extension EpisodeTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as? EpisodeTableViewCell else {
            print("Identifier for cell does not exist.")
            return UITableViewCell()
        }
        
        cell.titleLabel.text = episodes[indexPath.row].name
        cell.titleLabel.numberOfLines = 0
        cell.seasonLabel.text = "S:\(episodes[indexPath.row].season) E:\(episodes[indexPath.row].number)"
        if #available(iOS 13.0, *) {
            if let image = episodes[indexPath.row].image {
                cell.episodeImageView.getImage(with: image.secureMedium) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Error occurred during image: \(error)")
                        DispatchQueue.main.async {
                            cell.episodeImageView.image = UIImage(systemName: "xmark")
                        }
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.episodeImageView.image = image
                        }
                    }
                }
            } else {
                cell.episodeImageView.image = UIImage(systemName: "xmark")
            }
        }
        return cell
    }
}
