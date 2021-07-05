//
//  EpisodeInfoAPIClient.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/14/19.
//

import Foundation

class EpisodeInfoAPIClient {
    
    static let shared = EpisodeInfoAPIClient()
    
    func getEpisodeInfo(edInt: Int, completionHandler: @escaping ((Result<EpisodeDetailInfo,AppError>)-> Void)){
    
        let urlString = "http://api.tvmaze.com/episodes/\(edInt)"
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
                    let searchData = try JSONDecoder().decode(EpisodeDetailInfo.self, from: data)
                    completionHandler(.success(searchData))
                }catch let badJSONError {
                    print(badJSONError.localizedDescription)
                    completionHandler(.failure(.badJSONError))
                }
            }
            
            }.resume()
    
    
        }
        
    }
    
    
    
    

