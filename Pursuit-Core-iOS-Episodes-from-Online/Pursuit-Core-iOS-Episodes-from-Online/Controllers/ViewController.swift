//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showsTableView: UITableView!
    
    var shows = [Show]() {
        didSet {
            DispatchQueue.main.async {
                self.showsTableView.reloadData()
            }
        }
    }
    
    
    private func loadData() {
        Show.getShowData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showsFromOnline):
                    self.shows = showsFromOnline
                    dump(showsFromOnline)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.dataSource = self
        showsTableView.delegate = self
        loadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showsTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)  as! showsTableViewCell
        let currentShow = shows[indexPath.row]

        cell.TitleLabel.text = currentShow.name
        cell.rating.text = "\(currentShow.rating?.average ?? 0.0)"
        
        ImageHelper.shared.fetchImage(urlString: currentShow.image.original) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                   cell.showsImage.image = imageFromOnline
                }
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164
    }
}




