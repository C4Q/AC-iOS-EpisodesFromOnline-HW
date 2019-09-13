//
//  EpisodesViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Malcolm S. Turnquest on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {

     var show: TVShowsWrapper?
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

    extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return episodes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = episodeTable.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesTableViewCell
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
