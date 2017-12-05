//
//  ShowsViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController, UITableViewDelegate, UITableViewDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsSearchBar.delegate = self
    }

    @IBOutlet weak var showsSearchBar: UISearchBar!
    
    @IBOutlet weak var showsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
