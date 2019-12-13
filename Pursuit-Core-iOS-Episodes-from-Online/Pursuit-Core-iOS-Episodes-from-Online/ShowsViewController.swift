//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var shows = [Show](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        delegateMethods()
    }
    
    func loadData(){
        TVMazeAPIClient.fetchTVShows(searchQuery: "") { [weak self] (result) in
            switch result{
            case.failure(let appError):
                DispatchQueue.main.async {
                    self?.displayAlertController(title: "ERROR", message: "\(appError)")
                }
            case .success(let shows):
                self?.shows = shows
            }
        }
    }
    
    func delegateMethods(){
        tableView.dataSource = self
    }
}

extension ShowsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell creation
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else { fatalError("failed to dequeCell")
        }
        return cell
    }
}

