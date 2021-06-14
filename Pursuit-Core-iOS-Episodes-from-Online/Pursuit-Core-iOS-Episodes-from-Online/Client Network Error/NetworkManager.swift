//
//  NetworkManager.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // TODO - later update 'private init' to cache
    private init() {}
    static let shared = NetworkManager()
    
    // Performs GET requests
    // Parameters: URL as a string
    // Completion: Result with Data in success, AppError in failure
    func fetchData(urlString: String, completionHandler: @escaping (Result<Data, AppError>) -> () ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.networkError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.badHTTPResponse))
                return
            }
            switch response.statusCode {
            case 404:
                completionHandler(.failure(.notFound))
            case 401, 403:
                completionHandler(.failure(.unauthorized))
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.other(rawError: "Wrong status code")))
            }
            }.resume()
    }
}
