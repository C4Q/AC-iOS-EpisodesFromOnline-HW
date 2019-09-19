//
//  ShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    //search Variables
//     var searchNames = [String]()
    var searchResults = [Shows]()
    
    //searchController
    let searchController = UISearchController(searchResultsController: nil)
//search function
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    @IBOutlet weak var showTable: UITableView!
    
    var showData = [Shows](){
        didSet {
            DispatchQueue.main.async
                {
                    self.showTable.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        // Do any additional setup after loading the view.
    }
    private func loadData() {
        ShowAPIClient.manager.getProjects { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(shows):
                    self?.searchResults = shows
                case let .failure(error):
                    self?.displayErrorAlert(with: error)
                }
            }
        }
    }
    func setup() {
        showTable.dataSource = self
       showTable.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Shows"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }

    
    private func displayErrorAlert(with error: AppError) {
        let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension ShowViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return searchResults.count
        }
        
        return showData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
      
        if let cell = showTable.dequeueReusableCell(withIdentifier: "showCell") as? ShowCell {
            do {
                let url = URL(string: "\(searchResults[indexPath.row].image.medium)")!
                let data = try Data(contentsOf: url)
                cell.showImage.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
            
            if isFiltering() {
                cell.showTitle.text = searchResults[indexPath.row].name
                cell.genreLabel.text = searchResults[indexPath.row].genres.genre[0]
                cell.premierLabel.text = searchResults[indexPath.row].premiered
                cell.ratingLabel.text = "\( searchResults[indexPath.row].rating.average)"
            }
            else {
                
            }
            return cell
        }
        return UITableViewCell()
    }
}

}

extension ShowViewController: UISearchBarDelegate, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        ShowAPIClient.showName = searchText.lowercased()
//        searchResults = showData.filter({( result : Shows) -> Bool in
//        return result.name.lowercased().contains(searchText.lowercased())
//        })
    
       showTable.reloadData()
    }
    
}
