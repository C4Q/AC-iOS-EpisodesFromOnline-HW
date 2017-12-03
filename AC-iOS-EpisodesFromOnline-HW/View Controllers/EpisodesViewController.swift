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
    var episodes: [Episode]?{
        didSet{
           // print(episode! + "/episodes")
            getEpisodeData()
            episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        getEpisodeData()
    }
    
    func getEpisodeData(){
        //get urlStr
        
        let urlStr = "http://api.tvmaze.com/episodes/10820" + "/episodes"
        //set completion
        let completion: ([Episode]) -> Void = {(onlineEpisode: [Episode]) in
            self.episodes = onlineEpisode
        }
        //set errorHandler
        let errorHandler: (Error) -> Void = {(error: Error) in
            //alert pop up box
            //                        let alertController = UIAlertController(title: "Error", message: "An error occurred: \(error)", preferredStyle: UIAlertControllerStyle.alert)
            //                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            //                        alertController.addAction(okAction)
            //                        alertController.view.layoutIfNeeded() //avoid Snapshotting error
            // 
        }
        //call EpisodesAPIClient
        EpisodeAPIClient.manager.getEpisode(from: urlStr,
                                            completetionHandler: completion,
                                            errorHandler: errorHandler)
    }
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? DetailEpisodeViewController {
//            // set selected row
//            //set selected show
//        }
//    }
}



// MARK: - TableView Set-up

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let customCell and dequee cell
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesTableViewCell else {return UITableViewCell()}
        let  episode = episodes![indexPath.row]
        //set properties : image, name, season/episodeNumber
        //set default episode image
        episodeCell.episodeName.text = episode.name
        episodeCell.seasonAndEpisodeNumber.text = "Season: \(episode.season) / Episode: \(episode.number)"
        
        //Set defaultImage
        //episodeCell.EpisodeImage.image = //default image
        
        /// MARK: - Getting Image
        //make sure you can conver the url into an image
        //set completion
        //call IMAGEAPICLient
        
        return UITableViewCell()
    }
    
}

