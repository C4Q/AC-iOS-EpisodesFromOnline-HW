//
//  SeriesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Richard Crichlow on 12/1/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var seriesTableView: UITableView!
    
    var aSeriesHref: String? {//this needs to get populated by the segue from the TVViewController
        didSet {
            print(aSeriesHref! + "/episodes")
            loadSeriesData()
            //seriesTableView.reloadData()
        }
    }
    
    var allEpisodesInASeries = [EpisodeStruct]() {
        didSet {
            self.seriesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seriesTableView.dataSource = self
        self.seriesTableView.delegate = self
        guard aSeriesHref != nil else {return}
        //loadSeriesData()
    }
    
    func loadSeriesData(){
        let url = aSeriesHref! + "/episodes"
        let completion: ([EpisodeStruct]) -> Void = {(onlineSeries: [EpisodeStruct]) in
            self.allEpisodesInASeries = onlineSeries
        }
        SeriesAPIClient.manager.getAllEpisodes(from: url, completionHandler: completion , errorHandler: {print($0)})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodesInASeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = seriesTableView.dequeueReusableCell(withIdentifier: "seriesCell", for: indexPath) as? SeriesTableViewCell else {return UITableViewCell()}
        let anEpisode = allEpisodesInASeries[indexPath.row]
        
        cell.seriesImageView.image = #imageLiteral(resourceName: "defaultTVImage") //Default Image
        cell.seriesNameLabel.text = "Name: \(anEpisode.name ?? "TBA")"
        cell.seriesSeasonLabel.text = "Season: \(anEpisode.season ?? 0)"
        cell.seriesEpisodeLabel.text = "Episode: \(anEpisode.number ?? 0)"
        
        //PUT IMAGE API HERE
        if let urlStr = anEpisode.image?.medium {
            cell.spinner.isHidden = false
            cell.spinner.startAnimating()
            let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.seriesImageView.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.getImage(from: urlStr,
                                            completionHandler: setImageToOnlineImage,
                                            errorHandler: {print($0)})
            cell.spinner.stopAnimating()
            cell.spinner.isHidden = true
            
        } else {
            spinner.isHidden = true
            cell.seriesImageView.image = #imageLiteral(resourceName: "defaultTVImage")
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedViewController {
            let selectedRow = self.seriesTableView.indexPathForSelectedRow!.row
            let selectedShow = self.allEpisodesInASeries[selectedRow]
            destination.anEpisode = selectedShow
        }
    }
    
    
}
