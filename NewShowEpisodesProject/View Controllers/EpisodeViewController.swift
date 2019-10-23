//
//  EpisodeViewController.swift


import UIKit

class EpisodeViewController: UIViewController {

  
    @IBOutlet weak var episodeTableView: UITableView!
    
    
    var show: ShowModel?
    
    
    var episodes: [EpisodeModel]? {
        didSet{
            episodeTableView.reloadData()
        }
    }
    
    
    
    
    var pickEpisode = "" {
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
        
    ShowAPIClient.shared.getEpisodes(searchTerm: "\(show?.show.id ?? 0)") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let EmbeddedContent):
                    self.episodes = EmbeddedContent
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = episodeTableView.indexPathForSelectedRow,
            let destination = segue.destination as? EpisodeDetailViewController else {return}
        let episodeInfoToSendOver = episodes?[indexPath.row]
       destination.episodeInfo = episodeInfoToSendOver
   }
}



extension EpisodeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell else {return UITableViewCell()}
        let eachEpisode = episodes?[indexPath.row]
        cell.episodeName.text = eachEpisode!.name
        cell.episodeSeason.text = "S: \(eachEpisode!.season), E: \(eachEpisode!.epiNumber)"
        
        
        guard let imageUrl = eachEpisode?.image?.medium else {
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





