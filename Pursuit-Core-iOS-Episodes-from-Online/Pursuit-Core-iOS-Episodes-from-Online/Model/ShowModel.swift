//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by albert coelho oliveira on 9/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowsWrapper: Codable{
    let show: Shows
    
    static func getShow(userInput: String?,completionHandler: @escaping (Result<[ShowsWrapper],AppError>) -> () ) {
        var url = "https://api.tvmaze.com/search/shows?q=g)"
        if let word = userInput{
          let newString = word.replacingOccurrences(of: " ", with: "-")
         url = "https://api.tvmaze.com/search/shows?q=\(newString)"
            }
        NetWorkManager.shared.fetchData(urlString: url) { (result) in
      print(url)
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedShow = try JSONDecoder().decode([ShowsWrapper].self, from: data)
                    completionHandler(.success(decodedShow))
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
    let summary: String?
    let runtime: Int?
    let image: imageWrapper?
    let rating: ratings?
    var fixedSummary: String{
        if let summary = summary{
            return summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)}
        return ""
    }
}
struct imageWrapper: Codable{
    let medium: String?
    let original: String?
}

struct ratings: Codable{
    let average: Double?
}
