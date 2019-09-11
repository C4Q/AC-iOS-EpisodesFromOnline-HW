//
//  AllShowsModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class AllShowsAPIHelper {
    static let shared = AllShowsAPIHelper()
    private init () {}
    
    
    
    func getShow(name:String?,completionHandler: @escaping(Result<[ShowWrapper],AppError>) -> ()) {
        var urlStr = "http://api.tvmaze.com/search/shows?q=girls"
        if let showName = name{
            let newShowName = showName.replacingOccurrences(of: " ", with: "-")
            
            urlStr = "http://api.tvmaze.com/search/shows?q=\(newShowName)"
        }
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do { let show = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completionHandler(.success(show))
                } catch {
                    completionHandler(.failure(.networkError))
                    print(error)
                }
            }
        }
    }
}



