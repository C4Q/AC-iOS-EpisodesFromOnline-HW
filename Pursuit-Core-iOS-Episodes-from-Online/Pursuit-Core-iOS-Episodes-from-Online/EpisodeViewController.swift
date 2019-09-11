//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Kary Martinez on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//
//
//import UIKit
//
//class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var episodoes = [Show]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.EpisodesTableView.reloadData()
//            }
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return episodoes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
