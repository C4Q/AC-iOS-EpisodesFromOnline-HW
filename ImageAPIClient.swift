//
//  ImageAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlStr: String,
                  completionHander: @escaping (UIImage) -> Void,
                  errorHander: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHander(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHander(.notAnImage)
                return
            }
            completionHander(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
