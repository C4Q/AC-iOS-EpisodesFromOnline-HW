//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewShow = [Shows](){
        didSet {
    showTableVIew.reloadData()
    }
}
    @IBOutlet weak var showTableVIew: UITableView!
    @IBOutlet weak var showSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableVIew.delegate = self
        showTableVIew.dataSource = self
        showSearchBar.delegate = self
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
}

