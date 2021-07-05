//
//  ViewController.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/10/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    
    var shows = [AllInfo]() {
        didSet{
            showTableView.reloadData()
        }
    }
    
    var searchedShow = "" {
        didSet{
            showTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showTableView.dataSource = self
        showTableView.delegate = self
        showSearchBar.delegate = self
        
    }
    private func loadShows(){
        ShowAPIClient.shared.getShow(showTitle: searchedShow) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let AllInfo):
                    self.shows = AllInfo
                }
                
                
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = showTableView.indexPathForSelectedRow,
            let destination = segue.destination as? DetailEpisodeViewController else {return}
        let showInfoToSendOver = shows[indexPath.row]
        destination.episodeID = showInfoToSendOver
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell") as? ShowTableViewCell else {return UITableViewCell()}
        let eachShow = shows[indexPath.row]
        
       cell.showTitle.text = eachShow.show.name
       cell.showEpisode.text = eachShow.show.rating.average?.description
        
        guard let imageUrl = eachShow.show.image?.original else {
            return UITableViewCell()
        }
        ImageHelper.shared.getImage(urlStr: imageUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.showImage.image = image
                }
            }
        }
        
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedShow = searchText
        loadShows()
    }
}
