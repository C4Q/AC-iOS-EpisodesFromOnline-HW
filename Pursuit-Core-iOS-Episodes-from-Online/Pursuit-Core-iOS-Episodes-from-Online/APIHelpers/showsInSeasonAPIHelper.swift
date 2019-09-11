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
    
    
    
    func getShowInsideOfSeasonb(ID:Int,completionHandler: @escaping(Result<[Episode],AppError>) -> ()) {
        let urlStr = "http://api.tvmaze.com/shows/\(ID)/episodes"
        
        
        
        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    print("The data is")
                    print(String(data: data, encoding: .utf8)!)
                    let show = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(show))
                } catch {
                    print(" the real problem is...:")
                    print(error)
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
}



