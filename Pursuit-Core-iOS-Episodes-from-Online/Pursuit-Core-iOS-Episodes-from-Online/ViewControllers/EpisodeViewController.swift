//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by albert coelho oliveira on 9/9/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    var show: ShowsWrapper?
    var episodes = [Episodes](){
        didSet {
            episodeTable.reloadData()
          
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
}
