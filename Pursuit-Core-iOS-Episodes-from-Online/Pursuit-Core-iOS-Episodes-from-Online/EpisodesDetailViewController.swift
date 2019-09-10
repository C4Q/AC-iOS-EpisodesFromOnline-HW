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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeCell
        let currentEpisode = episodes[indexPath.row]
        cell.nameLabel.text = currentEpisode.name
        cell.seasonEpisodeLabel.text = currentEpisode.seasonAndEpisode
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    private func loadEpisode(id: Int? ){
        Episode.getEpisode(episodeID: id ?? 13 ) { (result) in
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
        loadEpisode(id: endPoint?.id)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
