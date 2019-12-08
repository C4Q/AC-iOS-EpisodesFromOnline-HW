//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var data = Data(){
        didSet{
            print(data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        NetworkHelper.shared.getData(using: "http://api.tvmaze.com/search/shows?q=girls") { result in
            switch result{
            case .failure(let error):
                print("Encountered Error: \(error)")
            case .success(let validData):
                self.data = validData
            }
        }
    }


}

