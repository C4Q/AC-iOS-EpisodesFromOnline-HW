//
//  ShowsViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension ShowsViewController: UITableViewDelegate {
    
}
