//
//  SeriesAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct SeriesAPI {
    static func getSeries(using urlString: String, completion: @escaping (Result<[Series],NetworkError>) -> ()){
        NetworkHelper.shared.getData(using: urlString) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do{
                    let shows = try JSONDecoder().decode([Series].self, from: data)
                    completion(.success(shows))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
