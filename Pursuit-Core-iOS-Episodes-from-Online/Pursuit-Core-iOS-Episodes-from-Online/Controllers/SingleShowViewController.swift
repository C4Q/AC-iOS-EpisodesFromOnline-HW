//
//  SingleShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SingleShowViewController: UIViewController {

    @IBOutlet weak var SingleShowTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

}

extension SingleShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell id = ShowListTVC
        return UITableViewCell()
    }
    
    
}

extension SingleShowViewController: UITableViewDelegate {
    
}
