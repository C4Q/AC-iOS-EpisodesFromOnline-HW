//
//  ImageAPIClient.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

struct ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badUrl); return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.failedToGetImage); return}
                completionHandler(onlineImage)
        }
        NetworkHelper.manager.performTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
