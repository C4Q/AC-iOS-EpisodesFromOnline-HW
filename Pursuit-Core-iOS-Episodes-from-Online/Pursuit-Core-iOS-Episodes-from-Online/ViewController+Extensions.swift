//
//  ViewController+Extensions.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlertController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
