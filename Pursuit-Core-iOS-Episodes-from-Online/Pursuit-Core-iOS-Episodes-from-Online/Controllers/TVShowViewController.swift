//
//  TVShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Eric Widjaja on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TVShowViewController: UIViewController {
    
    
    //MARK: -- Outlets and properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var tvshow = [TVShow]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var filteredShows: [TVShow] {
        get {
            guard let searchString = searchString else { return tvshow }
            guard searchString != ""  else { return tvshow }
            return TVShow.getFilteredTVShows(arr: tvshow, searchString: searchString)
        }
    }
    
    
    var searchString: String? = nil { didSet { self.tableView.reloadData()} }
    
    //MARK: -- Segue functions
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let segueIdentifer = segue.identifier else {fatalError("No identifier in segue")}
//
//        switch segueIdentifer {
//        case "segueToEpisodes":
//            guard let destVC = segue.destination as? SpecificShowViewController else { fatalError("Unexpected segue VC") }
//            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { fatalError("No row selected") }
//            let selectedShow = filteredShows[selectedIndexPath.row]
//            let selectedShowIDURl = "http://api.tvmaze.com/shows/\(selectedShow.id)/episodes"
//            destVC.currentShowURL = selectedShowIDURl
//            destVC.currentShowName = selectedShow.name
//
//            let backItem = UIBarButtonItem()
//            backItem.title = "Shows"
//            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
//    
//
//        default:
//            fatalError("unexpected segue identifier")
//        }
//    }

    private func loadData(){
        TVShow.getTVShowData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showData):
                    self.tvshow = showData
                    self.tvshow = TVShow.getSortedArray(arr: self.tvshow)
                }
            }
        }
    }
    
    private func configureDelegateDataSources(){
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    //Mark - Views Notifying Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegateDataSources()
        loadData()
    }
}

//MARK: -- Datasource Methods
extension TVShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredShows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentShow = filteredShows[indexPath.row]
        let tvShowCell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as! ShowTableViewCell
        
        tvShowCell.showNameLabel.text =  currentShow.name
        tvShowCell.showRatingLabel.text = "Rating: \(currentShow.rating?.average ?? 0.0)"
        ImageHelper.shared.fetchImage(urlString: currentShow.image.original) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    tvShowCell.showImage.image = imageFromOnline
                }
            }
        }
        return tvShowCell
    }
}

//MARK: -- Delegate Methods

extension TVShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension TVShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
