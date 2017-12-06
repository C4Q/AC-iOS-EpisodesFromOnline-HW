//
//  NetworkHelper.swift
//  Unit3Week2HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
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
