//
//  DetailEpisodeViewController.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/13/19.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
   
    
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodeID : AllInfo!
    var episodes = [EpisodeInfo](){
        didSet{
            episodeTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
        loadEpisodes()

    }
    
    func loadEpisodes(){
        
        EpisodeAPIClient.shared.getEpisode(episodeInt: episodeID.show.id ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let EpisodeInfo):
                    self.episodes = EpisodeInfo
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = episodeTableView.indexPathForSelectedRow,
            let destination = segue.destination as? EpisodeInfoViewController else {return}
        let episodeInfoToSendOver = episodes[indexPath.row]
        destination.episodeSource = episodeInfoToSendOver
    }
}



extension DetailEpisodeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell else {return UITableViewCell()}
        let eachEpisode = episodes[indexPath.row]
        cell.episodeTitle.text = eachEpisode.name
        cell.episodeInfoLabel.text = "Season: \(eachEpisode.season), Episode: \(eachEpisode.id)"
        
        
        guard let imageUrl = eachEpisode.image?.original else {
            return UITableViewCell()
        }
        ImageHelper.shared.getImage(urlStr: imageUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.episodeImage.image = image
                }
            }
        }

        return cell
    }


}




