//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.x


import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.episodeTableView.reloadData()
            }
        }
        
    }
    
    var testThisType = "0.004423244324232"
    var show : Show!
    
    private func loadData() {
        Episode.getEpisodeData(showID: show.id) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let episodesFromOnline):
                    self.episodes = episodesFromOnline
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifer = segue.identifier else {fatalError("No indentifier in segue")}
        
        switch segueIdentifer {
            
        case "segToDV":
            guard let destVC = segue.destination as? showsDetailViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = episodeTableView.indexPathForSelectedRow else {fatalError("No row selected")
                
            }
            
            let currentEpisode = episodes[selectedIndexPath.row]
            destVC.currentEpisode = currentEpisode
            
        default:
            fatalError("unexpected segue identifier")
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "episodesCell", for: indexPath) as! EpisodesTableViewCell
        let currentEpisode = episodes[indexPath.row]
        cell.episodesName.text = currentEpisode.name
        cell.seasonName.text = "S:\(currentEpisode.season)"
        cell.backgroundColor = UIColor.black
        cell.episodesName.textColor = UIColor.white
        cell.seasonName.textColor = UIColor.white

        if let episodeImage = currentEpisode.image?.original {
            ImageHelper.shared.fetchImage(urlString: episodeImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        cell.EpisodesImage.image = imageFromOnline

                    }
                }
            }
        } else {
            cell.EpisodesImage.image = UIImage(named: "noImage")
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        loadData()
        
    }
    
}
