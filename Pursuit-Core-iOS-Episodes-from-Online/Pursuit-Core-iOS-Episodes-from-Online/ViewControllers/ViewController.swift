//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var showTableVIew: UITableView!
    @IBOutlet weak var showSearchBar: UISearchBar!
    var viewShow = [ShowsWrapper](){
        didSet {
            showTableVIew.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableVIew.delegate = self
        showTableVIew.dataSource = self
        showSearchBar.delegate = self
        loadData(word: nil)
    }
    var userSearchTerm: String? {
        didSet {
            self.showTableVIew.reloadData()
        }
    }
    var filteredShow: [ShowsWrapper]  {
        guard let userSearchTerm = userSearchTerm else {
            return viewShow
        }
        guard userSearchTerm != "" else {
            return viewShow
        }
        return viewShow
    }
   

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showVc = segue.destination as? EpisodeViewController else {
            fatalError("Unexpected segue")
        }
        guard let selectedIndexPath = showTableVIew.indexPathForSelectedRow
            else { fatalError("No row selected") }
        showVc.show = filteredShow[selectedIndexPath.row]
    }
    func loadData(word: String?){
        ShowsWrapper.getShow(userInput: word){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let shows):
                DispatchQueue.main.async{
                    return self.viewShow = shows
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showTableVIew.dequeueReusableCell(withIdentifier: "showListCell", for: indexPath) as? ShowListTableViewCell
        let shows = filteredShow[indexPath.row].show
        if let url = shows.image?.medium{
            ImageHelper.shared.fetchImage(urlString: url) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell?.showImage.image = image
                    }}}
        }
        cell?.showName.text = shows.name
        if let run = shows.runtime?.description{
            cell?.runtime.text = "\(run) Mins"
        }
        else {
            cell?.runtime.text = "No runtime"}
        if let rate = shows.rating?.average?.description{
            cell?.rating.text = rate}else {
            cell?.rating.text = "No rating"
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
        loadData(word: searchText)
    }
}
