//
//  NetworkHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/7/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class NetworkHelper {
     
    // MARK: Properties
    
    private var session: URLSession
    static let shared = NetworkHelper()
    
    // MARK: Initializer
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func getData(using urlString: String, completion: @escaping (Result<Data,NetworkError>) -> ()){
        
        guard let fileURL = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let dataTask = session.dataTask(with: fileURL) { (data,response,error) in
            if let error = error{
                completion(.failure(.networkClientError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            switch httpResponse.statusCode{
            case 200...299:
                break
            default:
                completion(.failure(.badStatusCode(httpResponse.statusCode)))
                return
            }
            
            completion(.success(data))
            
        }
        dataTask.resume()
    }
}
