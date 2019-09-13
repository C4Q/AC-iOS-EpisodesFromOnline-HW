//
//  ImageHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/12/19.
//  Co, pyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit

struct ImageHelper {
    static func getImage(stringUrl: String, completionHandler: @escaping (AppError?, UIImage?) -> Void ) {
    guard let url = URL.init(string: stringUrl) else {
        completionHandler(AppError.badUrl, nil)
        return
        }
        
        let request = URLRequest.init(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.badHTTPResponse, nil)
            } else if let data = data {
                let foto = UIImage.init(data: data)
                completionHandler(nil, foto)
            }
        }.resume()
    }
}
