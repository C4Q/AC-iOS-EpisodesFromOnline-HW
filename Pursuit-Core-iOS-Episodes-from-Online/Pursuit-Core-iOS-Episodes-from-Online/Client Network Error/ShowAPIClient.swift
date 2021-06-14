//
//  ShowAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class ShowAPIClient {
    private init() {}
    
    static var shared = ShowAPIClient()
    
    
    func getShows(userSearchTerm: String?, completionHandler: @escaping (Result<[ShowWrapper], AppError>) -> () ) {
        if let urlString = userSearchTerm {
            let noSpacesURL = urlString.replacingOccurrences(of: " ", with: "-")
           let urlStr = "http://api.tvmaze.com/search/shows?q=\(noSpacesURL)"
        
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure( _):
                completionHandler(.failure(.badURL))
            case .success(let data):
                do {
                    let showInfo = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completionHandler(.success(showInfo))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
                
            }
        }
        }
        
    }
    
    
}
