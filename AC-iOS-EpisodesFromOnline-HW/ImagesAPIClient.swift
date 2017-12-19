//
//  ImagesAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class ImagesAPIClient {
    private init() {}
    static let manager = ImagesAPIClient()
    func getImage(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badImageURL)
            return
        }
        
        NetworkHelper.manager.getData(
            from: url,
            completionHandler: { (data) in
                guard let image = UIImage(data: data) else {
                    errorHandler(AppError.badImageData)
                    return
                }
                
                completionHandler(image)
        },
            errorHandler: errorHandler)
    }
}
