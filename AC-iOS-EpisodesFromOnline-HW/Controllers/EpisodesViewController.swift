//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = show.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadEpisodes()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Variables & Constants
    var show: Show! //passed from the Show view controller in segue
    var episodes = [Episode]() {
        didSet {
           tableView.reloadData()
        }
    }
    
    
    //MARK: Function
    func loadEpisodes(){
        let urlStr = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        
        let setEpisodes = { (onlineEpisodes: [Episode]) in
            self.episodes = onlineEpisodes
        }
        
        let printErrors = {(error: Error) in
            print(error)
        }
        
        EpisodesAPIClient.manager.getEpisodes(withURL: urlStr, completionHandler: setEpisodes, errorHandler: printErrors)
        
    }
    
    //MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    //numberOfRowsinSection
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //part #1 - define the cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) //else {return UITableViewCell()}
    
        //part #2 - getting the show info from the shows array for each row
        let episode = episodes[indexPath.row]
        
        //part #3 - display the show info for each cell
        cell.textLabel?.text = episode.name
        cell.detailTextLabel?.text = "Season: \(episode.season) Episode: \(episode.number)"
        
        //part #4 - display Image for cell - for each show
        guard let imageURL = (episode.image?.original ?? episode.image?.medium) else {return cell}
        let setImage: (UIImage)->Void = { (onlineImage: UIImage) in
            cell.imageView?.image = onlineImage //set the image url
            cell.setNeedsLayout() //updates image to ensure its correct while scrolling
        }
        let printErrors = {(error: Error) in print(error)}
        ImageAPIClient.manager.getImage(from: imageURL, completionHandler: setImage, errorHandler: printErrors)
        
        //part #5 - return the cell
        return cell
    }
    
    //MARK: TableView Delegate Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Navigation - Segue to EpisodeDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let EpisodeDetailedViewController = segue.destination as? EpisodesDetailedViewController else {return}
        
        let selectedRow = tableView.indexPathForSelectedRow!.row
        
        let selectedEpisode = episodes[selectedRow]
        EpisodeDetailedViewController.episode = selectedEpisode
        
    }

}
