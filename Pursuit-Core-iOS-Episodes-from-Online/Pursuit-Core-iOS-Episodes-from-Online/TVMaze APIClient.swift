//
//  TVMaze APIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Bienbenido Angeles on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class TVMazeAPIClient{
    static func fetchTVShows(searchQuery: String, completion: @escaping (Result<[Show], AppError>)->()){
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let endPointURLString = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badUrl(endPointURLString)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let showData = try JSONDecoder().decode([ShowData].self, from: data)
                    let show = showData.map{$0.show}
                    completion(.success(show))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
