//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by albert coelho oliveira on 9/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowsWrapper: Codable{
    let show: [Shows]
    static func getShow(completionHandler: @escaping (Result<[Shows],AppError>) -> () ) {
        let url = "https://randomuser.me/api/?results=50"
        NetWorkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedShow = try JSONDecoder().decode(ShowsWrapper.self, from: data)
                    completionHandler(.success(decodedShow.show))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}
struct Shows: Codable {
    let id: Int
    let name: String
    let type: String
    let summary: String
    let image: imageWrapper
    let runtime: Int
}
struct imageWrapper: Codable{
    let image: String
    let original: String
}
