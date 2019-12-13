//
//  UIImageView+Extensions.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(withEndPointURLString: String, completion: @escaping (Result<UIImage, AppError>)->()){
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = center
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        
        guard let url = URL(string: withEndPointURLString) else {
            completion(.failure(.badUrl(withEndPointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
}
