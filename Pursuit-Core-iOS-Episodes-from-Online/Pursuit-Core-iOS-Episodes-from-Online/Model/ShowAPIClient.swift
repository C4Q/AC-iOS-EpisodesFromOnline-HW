//
//  ShowAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Jack Wong on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//
import Foundation

struct ShowAPIClient {
    private init() {}
    static let manager = ShowAPIClient()
    func getShows(from urlStr: String,
                  completionHandler: @escaping ([Show]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        print(urlStr)
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badUrl);return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                if urlStr.contains("search") {
                    let results = try JSONDecoder().decode([Result].self, from: data)
                    completionHandler(results.map{$0.show})
                } else {
                    let shows = try JSONDecoder().decode([Show].self, from: data)
                    completionHandler(shows)
                }
                
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
