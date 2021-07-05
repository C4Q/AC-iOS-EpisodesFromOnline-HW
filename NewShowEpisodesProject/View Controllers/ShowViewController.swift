//
//  ShowViewController.swift
//  NewShowEpisodesProject


import UIKit

class ShowViewController: UIViewController {

   
    @IBOutlet weak var showSearchbar: UISearchBar!
    
    
    @IBOutlet weak var showTableView: UITableView!
    
    
    var shows = [ShowModel]() {
        didSet{
            showTableView.reloadData()
        }
    }
    
    var searchShow = "" {
        didSet{
            showTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.dataSource = self
        showTableView.delegate = self
        showSearchbar.delegate = self


    }
    



private func loadShows(){
 
    ShowAPIClient.shared.getShow(searchTerm: searchShow) { (result) in
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
            let destination = segue.destination as? EpisodeViewController else {return}
    let showInfoToSendOver = shows[indexPath.row]
        destination.show = showInfoToSendOver
    }

}


extension ShowViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ showTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ showTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return shows.count
    }
    
    func tableView(_ showTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = showTableView.dequeueReusableCell(withIdentifier: "showCell") as? ShowTableViewCell else {return UITableViewCell()}
        let eachShow = shows[indexPath.row]
        
       cell.showTitleLabel.text = eachShow.show.name
        cell.ratingLabel.text = eachShow.show.rating.average?.description
        
        
        let imageUrl = eachShow.show.image?.original ?? ""
        ImageHelper.shared.getImage(urlStr: imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    cell.showImageView.image = image
                case .failure( let error):
                    print (error)
                }
            }
        }
        
        return cell
    }
    
    
}

extension ShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchShow = searchText
        loadShows()
    }
}
