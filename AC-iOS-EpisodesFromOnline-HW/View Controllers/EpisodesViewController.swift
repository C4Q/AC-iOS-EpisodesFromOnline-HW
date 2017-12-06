//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showSelected: Shows!
    var id = ""
    var episodes = [Episodes]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
    }
    

    func loadData() {
        id = showSelected.show.id.description
        let urlStr = "http:api.tvmaze.com/shows/\(id)/episodes"
        let setShowsToOnlineShows: ([Episodes]) -> Void = {(onlineEpisodes: [Episodes]) in
            self.episodes = onlineEpisodes
        }
        EpisodesAPIClient.manager.getEpisodes(from: urlStr,
                                        completionHandler:setShowsToOnlineShows,
                                        errorHandler: {print($0)})
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedEpisode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as! EpisodeTableViewCell
        //TO DO: Create cell file and connect outlets for label and image
        //Then set cell labels in here
        //cell.episodeImageView.image = nil
        cell.episodeNamelabel.text = selectedEpisode.name
        cell.seasonAndEpisodeLabel.text = "E: \(selectedEpisode.number) S: \(selectedEpisode.season)"
        dump(selectedEpisode)
        //Then call the completion handler to get image from url
//        guard let imageUrlStr = selectedEpisode.image?.original else {
//            return cell //only executes if you cant make the url
//        }
        //Below the closure is being defined but its not running yet
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.episodeImageView?.image = onlineImage
            print("hello")
            cell.setNeedsLayout() //Makes the image load as soon as it's ready
        }
        //Now we are passing the closure down. The closure above can only run if it passes all of the errors. in the api client and the network helper.
        //Api client first the network helper
        if let image = selectedEpisode.image?.original {
        ImageAPIClient.manager.getImage(from: image,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        } else {
            cell.episodeImageView.image = #imageLiteral(resourceName: "NoImage")
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodeDetailViewController {
            let selectedEpisode = episodes[self.tableView.indexPathForSelectedRow!.row]
            destination.episodeSelected = selectedEpisode
        }
    }
}
