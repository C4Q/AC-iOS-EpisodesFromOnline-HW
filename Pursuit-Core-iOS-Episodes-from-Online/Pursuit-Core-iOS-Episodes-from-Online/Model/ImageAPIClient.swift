//
//  ImageAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
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
