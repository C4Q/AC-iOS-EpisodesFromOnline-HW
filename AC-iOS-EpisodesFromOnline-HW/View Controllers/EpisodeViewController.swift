//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Ashlee Krammer on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var shows: Show!
    
    var episodes: [Episode]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadEpisodes()
    }
    
    
    
    //loadEpisodes
    
    func loadEpisodes() {
        let urlStr = "http://api.tvmaze.com/shows/\(shows.show.id)/episodes"
        
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("Show Search: No internet connection")
            case .couldNotParseJSON:
                print("Show Search: Could Not Parse")
            case .badStatusCode:
                print("Show Search: Bad Status Code")
            case .badURL:
                print("Show Search: Bad URL")
            case .invalidJSONResponse:
                print("Show Search: Invalid JSON Response")
            case .noDataReceived:
                print("Show Search: No Data Received")
            case .notAnImage:
                print("Show Search: No Image Found")
            default:
                print("Show Search: Other error")
            }
        }
        
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: completion, errorHandler: errorHanlder)
        
    }
    
    
    
    //Section Count
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.episodes?.count != nil else {
            return 0
        }
            return self.episodes!.count
    
    }
    
    
    //Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath)
        let selectedEpisode = episodes![indexPath.row]
        
        if let cell = cell as? EpisodeTableViewCell {
            guard selectedEpisode.name != nil else {
                cell.episodeTitle.text = "No Name"
                return cell
            }
            cell.episodeTitle.text = selectedEpisode.name
            
            cell.episodeInfo.text = "S:\(selectedEpisode.season) E:\(selectedEpisode.number)"
            
            cell.episodeImage.image = nil
            guard let imageUrlStr = selectedEpisode.image?.medium else {
                cell.episodeImage.image = #imageLiteral(resourceName: "photo_not_available_large")
                return cell
            }
            
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.episodeImage.image = onlineImage
                cell.setNeedsLayout()
            }
            
            ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        }
        
    
        
        return cell
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? EpisodeDetailViewController
        let selectedEpisode = episodes![(tableView.indexPathForSelectedRow?.row)!]
        destination?.episodes = selectedEpisode
    }
    
    //CREATE TABLEVIEW METHODS TO CONFORM
    
}
