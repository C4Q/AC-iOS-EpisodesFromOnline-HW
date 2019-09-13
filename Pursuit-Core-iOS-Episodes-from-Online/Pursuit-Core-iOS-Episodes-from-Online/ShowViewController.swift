//
//  ShowViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by hildy abreu on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var showTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//       showTableView.dataSource = self
//       loadData()

        
    }
    

   
}
extension ShowViewController: UITableViewDelegate{
    
}
//extension ShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


//}
