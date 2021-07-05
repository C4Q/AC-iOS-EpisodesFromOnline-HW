//
//  ShowAPIClient.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/11/19.
//

import Foundation

class ShowAPIClient {
    
    static let shared = ShowAPIClient()
    
    func getShow(showTitle: String, completionHandler: @escaping ((Result<[AllInfo],AppError>)-> Void)){
        
        let urlString =  "http://api.tvmaze.com/search/shows?q=\(showTitle)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest){(data, _, error) in
            if error != nil {
                completionHandler(.failure(.badUrl))
            }else if let data = data {
                do {
                    let searchData = try JSONDecoder().decode([AllInfo].self, from: data)
                    completionHandler(.success(searchData))
                }catch let badJSONError {
                    completionHandler(.failure(.badJSONError))
                }
            }
            
            }.resume()
        
    }
    
    
}
