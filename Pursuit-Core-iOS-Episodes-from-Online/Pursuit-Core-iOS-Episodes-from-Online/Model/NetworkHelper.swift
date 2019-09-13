//
//  NetworkHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
enum AppError: Error {
    case badData
    case badUrl
    case failedToGetImage
}


struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    func performTask(with url: URL,
                     completionHandler: @escaping (Data) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        self.session.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler(AppError.badData); return
                }
                if let error = error {errorHandler(error)}
                completionHandler(data)
            }
            }.resume()
    }
}
