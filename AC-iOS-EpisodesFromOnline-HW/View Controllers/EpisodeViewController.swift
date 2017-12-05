//
//  EpisodeViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var show: Show?
    
    var episodes: [Episode] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    func loadNewEpisodes(){
        var showID = ""
        showID = (show?.show.id.description)!
        let urlStr = "https://api.tvmaze.com/shows/\(showID)/episodes"
        
        let completion: ([Episode]) -> Void = {(onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
            
            if self.episodes.isEmpty{
                self.tableView.allowsSelection = false
                self.popUp()
            }
        }
        
        let errorHanlder: (AppError) -> Void = {(error: AppError) in
            switch error{
            case .noInternetConnection:
                print("Episode List: No internet connection")
            case .couldNotParseJSON:
                print("Episode List: Could Not Parse")
            case .badStatusCode:
                print("Episode List: Bad Status Code")
            case .badURL:
                print("Episode List: Bad URL")
            case .invalidJSONResponse:
                print("Episode List: Invalid JSON Response")
            case .noDataReceived:
                print("Episode List: No Data Received")
            case .notAnImage:
                print("Episode List: No Image Found")
            default:
                print("Episode List: Other error")
            }
        }
        EpisodeAPIClient.manager.getShow(from: urlStr, completionHandler: completion, errorHandler: errorHanlder)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadNewEpisodes()
    }
    
    
    
    func popUp() {
        let message = "No Episodes Available!"
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}








extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if episodes.isEmpty{
            return 1
        }else{
            return episodes.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath)
        
        if let cell = cell as? EpisodeTableViewCell{
            guard !episodes.isEmpty else {
                cell.episodeTitle.text = ""
                cell.episodeDetails.text = ""
                return cell
                
            }
            cell.episodeTitle.isHidden = false
            cell.episodeDetails.isHidden = false
            cell.episodeImage.isHidden = false
            let episodeToSet = episodes[indexPath.row]
            cell.episodeTitle.text = "Title: " + episodeToSet.name
            cell.episodeDetails.text = "Season: " + episodeToSet.season.description + "     " + "Episode: " + episodeToSet.number.description
            cell.episodeImage.image = nil
            
            cell.activityIndicator.startAnimating()
            if episodeToSet.image?.original == nil{
                cell.episodeImage.image = #imageLiteral(resourceName: "image_not_available")
                cell.activityIndicator.stopAnimating()
            }else{
            let imageUrlStr = episodeToSet.image?.original
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.episodeImage.image = onlineImage
                cell.setNeedsLayout()
                cell.activityIndicator.stopAnimating()
            }
                
                ImageAPIClient.manager.getImage(from: imageUrlStr!, completionHandler: completion, errorHandler: {print($0)})
            
            }
        }
        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController{
            let selectedEpisode = episodes[(tableView.indexPathForSelectedRow?.row)!]
            destination.episode = selectedEpisode
        }
    }
}
