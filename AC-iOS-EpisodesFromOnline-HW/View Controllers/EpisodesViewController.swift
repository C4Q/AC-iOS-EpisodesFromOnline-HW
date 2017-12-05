//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    //acting like a viewWillAppear function -> episodes need to be populated by the segue before sending over
    var episodes: String? {
        didSet{
            getEpisodeData()
        }
    }

    //what is powering the app
    var allEpisodesFromTVShow = [Episode]() {
        didSet {
            episodesTableView.reloadData()
            if allEpisodesFromTVShow.isEmpty {
                episodesTableView.backgroundColor = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        getEpisodeData()
        //make sure you have a tv show
        //guard let show = show else {return}
        print(allEpisodesFromTVShow)
      
    }
    
    func getEpisodeData(){
        //get urlStr
        let urlStr = episodes! + "/episodes" //link segued over + episodes to complete the episodes api href
        //set completion
        let completion: ([Episode]) -> Void = {(onlineEpisode: [Episode]) in
            self.allEpisodesFromTVShow = onlineEpisode
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box
        }
        //call EpisodesAPIClient
        EpisodeAPIClient.manager.getEpisode(from: urlStr,
                                            completionHandler: completion,
                                            errorHandler: errorHandler)
    }
    
    // MARK: - Segue to DetailEpisodeViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailEpisodeViewController {
            // set selected row
            let selectedRow = self.episodesTableView.indexPathForSelectedRow!.row
            //set selected show
            let selectedDetailedEpisode = self.allEpisodesFromTVShow[selectedRow]
            destination.detailEpisodes = selectedDetailedEpisode
        }
    }
}


// MARK: - TableView Set-up
extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodesFromTVShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let customCell and dequee cell
        guard let episodeCell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesTableViewCell else {return UITableViewCell()}
        
        let episode = allEpisodesFromTVShow[indexPath.row]
        episodeCell.layer.borderWidth = 5
        episodeCell.layer.borderColor = UIColor.black.cgColor
        
        //set properties : image, name, season/episodeNumber
        episodeCell.episodeName.text = episode.name
        
        if episode.number != nil && episode.season != nil {
            episodeCell.seasonAndEpisodeNumber.text = "S: \(String(describing: episode.season!)) / E: \(String(describing: episode.number!))"
        } else{
            episodeCell.seasonAndEpisodeNumber.text = "not available"
        }
        
        
        //Set defaultImage
        episodeCell.EpisodeImage.image = #imageLiteral(resourceName: "defaultImage")
        
        /// MARK: - Getting Image
        //make sure you can convert the url into an image
        
        //if there's an imageCell -> do stuff, otherwise set default image cell
        if let imageUrlStr = episode.image?.medium {
            //set completion
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                episodeCell.EpisodeImage.image = onlineImage
                episodeCell.setNeedsLayout()
            }
            //call ImageAPIClient
            ImageAPI.manager.loadImage(from: imageUrlStr,
                                       completionHandler: completion,
                                       errorHandler: {print($0)})
        }else{
            episodeCell.EpisodeImage.image = #imageLiteral(resourceName: "defaultImage")
            
        }
        return episodeCell
    }
}
