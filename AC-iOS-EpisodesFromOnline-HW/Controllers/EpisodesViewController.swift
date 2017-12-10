//
//  EpisodesViewController.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = show.name
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Variables & Constants
    var show: Show! //passed from the Show view controller in segue
    var episodes = [Episode]() {
        didSet {
           tableView.reloadData()
        }
    }
    
    
    //MARK: Function
    func loadEpisodes(){
        let urlStr = "http://api.tvmaze.com/shows/\(show.id)/episodes"
        
        
    }
    
    //MARK: TableView DataSource
    //numberOfRowsinSection
    //cellforRowat
            //        -set the image - inside cellforRow
    
    
    //MARK: TableView Delegate Method
    //heightforrowat
    
    
    //MARK: - Navigation - Segue to EpisodeDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }

}
