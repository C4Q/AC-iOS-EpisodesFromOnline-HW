//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Lisa J on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var show: Show! {
        didSet {
            loadData()
        }
    }
    var episodes = [Episode]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var showInst: Show!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 140
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData() {
        let urlStr = "http://api.tvmaze.com/shows/\(show.show.id)/episodes"
        let setShowToEpisodes: ([Episode]) -> Void = {(onlineEpisode: [Episode]) in
            self.episodes = onlineEpisode
            
        }
        EpisodeAPIClient.manager.getEpisodes(from: urlStr, completionHandler: setShowToEpisodes, ErrorHandler: {print($0)})
    }


}
extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = "Season:\(episode.season) Episode:\(episode.number)"
        if let image = episode.image, let urlImage = image.medium {
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.imageView?.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlImage, completionHandler: completion, errorHandler: {print($0)})
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? EpisodeDetailViewController {
            destination.episode = self.episodes[self.tableView.indexPathForSelectedRow!.row]
            //send info from this selected row
        }
    }
}
