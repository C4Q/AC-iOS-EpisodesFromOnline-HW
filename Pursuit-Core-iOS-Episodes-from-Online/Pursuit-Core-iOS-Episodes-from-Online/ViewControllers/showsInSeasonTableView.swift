//
//  showsInSeasonTableView.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit

class ShowsInSeasonTableView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var passingInfo:Shows!
    var episodes = [Episode]() {
        didSet {
            showsInSeasonTableView.reloadData()
        }
    }
    @IBOutlet weak var showsInSeasonTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        getShows(number: passingInfo.id)
        
    }
    func getShows(number:Int) {
        ShowsInSeasonAPIHelper.shared.getShowInsideOfSeasonb(ID: passingInfo.id) {
            (results) in
            switch results {
            case .failure(let error):
                print(error)
           
            case .success(let gotShowData):
                DispatchQueue.main.async {
                    
                    self.episodes = gotShowData
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
         let cell = showsInSeasonTableView.dequeueReusableCell(withIdentifier: "episodes") as! ShowTableViewCell
            cell.showLabel.text = episode.name
            cell.seasonNumber.text = episode.seasonNameAndNumber
        if let image = episode.image {
            ImageHelper.shared.fetchImage(urlImage: image.original) {
                (results) in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let foundEpisodes):
                    DispatchQueue.main.async {
                        
                    
                        cell.showImageView.image = foundEpisodes
                    }
                }
    }
        } else {
            cell.showImageView.image = UIImage(named:"imageLoadError")
}
       return cell
        
}
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func setUP() {
        showsInSeasonTableView.delegate = self
        showsInSeasonTableView.dataSource = self
        
    }
    
}
