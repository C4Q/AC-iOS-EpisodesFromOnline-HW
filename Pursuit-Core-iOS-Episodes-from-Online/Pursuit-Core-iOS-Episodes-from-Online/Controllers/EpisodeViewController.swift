//
//  ShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
//MARK: IBOutlet and Properties
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodes = [showEpisode]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    var currentTVShowURL = String()
    
    //MARK: -- Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifer {
        case "segueToDetail":
                guard let destVC = segue.destination as? detailEpisodeViewController else { fatalError("Unexpected segue VC") }
                guard let selectedIndexPath = episodeTableView.indexPathForSelectedRow else { fatalError("No row selected") }
                let selectedEpisode = episodes[selectedIndexPath.row]
                destVC.currentEpisode = selectedEpisode
            default:
                fatalError("unexpected segue identifier")
            }
        }
    
    private func getSelectedShowData(newTVShowURL: String){
        showEpisode.getEpisodeData(showURL: newTVShowURL) {(result) in DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let newTVShowData):
                    self.episodes = newTVShowData
                }
            }
        }
    }
    private func setCellImage(ep: showEpisode, cell: EpisodeTableViewCell) {
        if let currentImage = ep.image?.original {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            
            ImageHelper.shared.fetchImage(urlString: currentImage) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageFromOnline):
                        cell.tvEpisodeImage.image = imageFromOnline
                        cell.activityIndicator.isHidden = true
                        cell.activityIndicator.stopAnimating()
                    }
                }
            }
        } else {
            //cell.tvEpisodeImage.image =
            cell.activityIndicator.isHidden = true
            cell.activityIndicator.stopAnimating()
        }
        
    }
    
    private func setCellText(ep: showEpisode, cell: EpisodeTableViewCell) {
        cell.episodeNameLabel.text = ep.name
        cell.episodeSeasonLabel.text = "S\(ep.season) E\(ep.number)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
        getSelectedShowData(newTVShowURL: currentTVShowURL)
    }
}

//MARK: Datasource Methods
extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEpisode = episodes[indexPath.row]
        let episodeCell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        setCellText(ep: currentEpisode, cell: episodeCell)
        setCellImage(ep: currentEpisode, cell: episodeCell)
        return episodeCell
    }
}

//MARK: - Delegate Method

extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

