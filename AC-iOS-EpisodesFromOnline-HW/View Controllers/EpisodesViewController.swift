//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Maryann Yin on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
