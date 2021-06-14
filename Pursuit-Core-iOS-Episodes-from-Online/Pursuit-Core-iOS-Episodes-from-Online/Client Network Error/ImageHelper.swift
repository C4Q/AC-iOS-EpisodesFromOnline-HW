//
//  ImageHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init() {}
    
    static let shared = ImageHelper()
    
    func fetchImage(urlImage: String, completionHandler: @escaping (Result<UIImage, AppError>) -> () ) {
        NetworkManager.shared.fetchData(urlString: urlImage) { (result) in
            switch result{
            case .failure:
                fatalError()
            case .success(let data):
                guard let image = UIImage(data: data) else {
            completionHandler(.failure(.badImageData))
                    return
                }
                completionHandler(.success(image))
            }
        }
    }
}
