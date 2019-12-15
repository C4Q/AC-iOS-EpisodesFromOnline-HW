//
//  EpisodeAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct EpisodeAPI{
    static func getEpisodes(using urlString: String, completion: @escaping (Result<[Episode],NetworkError>) -> ()){
        NetworkHelper.shared.getData(using: urlString) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do{
                    let eps = try JSONDecoder().decode([Episode].self, from: data)
                    completion(.success(eps))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
