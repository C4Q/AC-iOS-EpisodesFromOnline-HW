//
//  EpisodeAPIClient.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/13/19.
//

import Foundation

class EpisodeAPIClient {
    static let shared = EpisodeAPIClient()
    
    func getEpisode(episodeInt: Int, completionHandler: @escaping ((Result<[EpisodeInfo],AppError>)-> Void)){
        
        let urlString =  "http://api.tvmaze.com/shows/\(episodeInt)/episodes"
        print(urlString)
        
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
                    let searchData = try JSONDecoder().decode([EpisodeInfo].self, from: data)
                    completionHandler(.success(searchData))
                }catch let badJSONError {
                    completionHandler(.failure(.badJSONError))
                }
            }
            
            }.resume()
        
    }
    
    
}


