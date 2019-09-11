//
//  EpisodesDetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var endPoint: Show?
    var showName: String?
    
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    
    var episodes = [Episode]() {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodes.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeCell
//        let currentEpisode = episodes[indexPath.row]
//        cell.nameLabel.text = currentEpisode.name
//        cell.seasonEpisodeLabel.text = currentEpisode.seasonAndEpisode
//        ImageHelper.shared.fetchImage(urlString: currentEpisode.image?.medium ?? "") { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let data):
//                    cell.cellImage.image = data
//                }
//            }
//        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell
        let episode = episodes[indexPath.row]
        if let image = episode.image?.original{
            ImageHelper.shared.fetchImage(urlString: image) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell?.cellImage.image = image
                    }
                }
            }
        }
        
        cell?.nameLabel.text = episode.name
        cell?.seasonEpisodeLabel.text = episode.seasonAndEpisode
        cell?.summaryTextField.text = episode.updatedSummary
        return cell!
    }
        
    
        
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    private func loadEpisode(){
        Episode.getEpisode(episodeID: (endPoint?.id)! ) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.episodes = data
    }
            }
        }
    }
    
    override func viewDidLoad() {
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        loadEpisode()
        super.viewDidLoad()
    }
    


}


/*
 import UIKit
 
 class EpisodeViewController: UIViewController {
 var show: ShowsWrapper?
 @IBOutlet weak var showImage: UIImageView!
 @IBOutlet weak var showName: UILabel!
 @IBOutlet weak var showDescrip: UITextView!
 
 var episodes = [Episodes](){
 didSet {
 episodeTable.reloadData()
 setUpLabelsShow()
 }
 }
 @IBOutlet weak var episodeTable: UITableView!
 override func viewDidLoad() {
 super.viewDidLoad()
 episodeTable.delegate = self
 episodeTable.dataSource = self
 getData()
 }
 func getData(){
 Episodes.getEpisode(id: (show?.show.id)!){ (result) in
 switch result {
 case .failure(let error):
 print(error)
 case .success(let episode):
 DispatchQueue.main.async{
 return self.episodes = episode
 }
 }
 }
 }
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 guard let epVc = segue.destination as? DetailViewController else {
 fatalError("Unexpected segue")
 }
 guard let selectedIndexPath = episodeTable.indexPathForSelectedRow
 else { fatalError("No row selected") }
 epVc.episode = episodes[selectedIndexPath.row]
 }
 func setUpLabelsShow(){
 showName.text = show?.show.name
 showDescrip.text = show?.show.fixedSummary
 if let image = show?.show.image?.original{
 ImageHelper.shared.fetchImage(urlString: image) { (result) in
 DispatchQueue.main.async {
 switch result {
 case .failure(let error):
 print(error)
 case .success(let image):
 self.showImage.image = image
 }
 }
 }
 }}
 }
 
 extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource{
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return episodes.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = episodeTable.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? episodeTableViewCell
 let epi = episodes[indexPath.row]
 if let image = epi.image?.original{
 ImageHelper.shared.fetchImage(urlString: image) { (result) in
 DispatchQueue.main.async {
 switch result {
 case .failure(let error):
 print(error)
 case .success(let image):
 cell?.episodeImage.image = image
 }
 }
 }
 }
 
 cell?.episodeName.text = epi.name
 cell?.episodeNum.text = epi.episodeFormat
 cell?.episodeDescrip.text = epi.summary
 return cell!
 }
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return 140
 }
 }*/
