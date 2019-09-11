//
//  ShowAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

struct ShowAPIClient {
    static var shared = ShowAPIClient()
    let showURL = "http://api.tvmaze.com/shows?page=1"

    func getShows(completion:@escaping (Result<ShowWrapper, Error>) -> ()){
        guard let url = URL(string: showURL) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            //Error handler
            if let err = err {
                completion(.failure(err))
            }
            //success
            do {
                let shows = try JSONDecoder().decode(ShowWrapper.self, from: data!)
                completion(.success(shows))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
    }
}

