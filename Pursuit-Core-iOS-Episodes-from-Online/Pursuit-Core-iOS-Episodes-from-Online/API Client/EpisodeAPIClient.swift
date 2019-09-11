//
//  EpisodeAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit
//

//var showID = Int()
struct EPAPIClient {
    static var shared = EPAPIClient()
    static var showID = Int()
    let epURL = "http://api.tvmaze.com/shows/\(showID)/episodes"

    func getEp(completion:@escaping (Result<Episode, Error>) -> ()){
        guard let url = URL(string: epURL) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            //Error handler
            if let err = err {
                completion(.failure(err))
            }
            //success
            do {
                let shows = try JSONDecoder().decode(Episode.self, from: data!)
                completion(.success(shows))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
    }
}

