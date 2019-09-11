//
//  showsInSeasonModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
class ShowsInSeasonAPIHelper {
    static let shared = ShowsInSeasonAPIHelper()
    private init () {}
    
    
    
    func getShowInsideOfSeasonb(ID:Int?,completionHandler: @escaping(Result<Episode,AppError>) -> ()) {
        var urlStr = "http://api.tvmaze.com/shows/1/episodes"
        if let newID = ID {
            urlStr = "http://api.tvmaze.com/shows/\(newID)/episodes"
        }
        
        
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do { let show = try JSONDecoder().decode(Episode.self, from: data)
                    completionHandler(.success(show))
                } catch {
                    completionHandler(.failure(.networkError))
                }
            }
        }
    }
}



