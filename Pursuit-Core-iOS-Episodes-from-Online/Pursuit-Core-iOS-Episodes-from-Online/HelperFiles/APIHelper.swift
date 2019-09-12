//
//  APIHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Mariel Hoepelman on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

import Foundation

class ShowAPIHelper {
    private init () {}
    
    static let shared = ShowAPIHelper()
    
    func getShow(url: String, completionHandler: @escaping (Result<[Shows], AppError>) -> ()) {
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.badUrl))
            case .success(let data):
                do {
                    let showInfo = try JSONDecoder().decode([Shows].self, from: data)
                    completionHandler(.success(showInfo))
                } catch {
                    completionHandler(.failure(.noDataError))
                    
                }
            }
        }
    }
}
