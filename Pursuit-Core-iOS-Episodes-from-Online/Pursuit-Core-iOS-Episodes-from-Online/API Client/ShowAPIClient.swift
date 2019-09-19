//
//  ShowAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/11/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

struct ShowAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = ShowAPIClient()
    
    // MARK: - Internal Methods
    
    func getProjects(completionHandler: @escaping (Result<[Shows], AppError>) -> Void) {
        NetworkHelper.manager.getData(from: ShowAPIClient.airtableURL) { result in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let projects = try Shows.getShows(from: data)
                    completionHandler(.success(projects))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    // MARK: - Private Properties and Initializers
    static var showName = String()
    static var airtableURL: URL {
        guard let url = URL(string: "http://api.tvmaze.com/search/shows?q=\(ShowAPIClient.showName)") else {
            fatalError("Error: Invalid URL")
        }
        print(url)
        return url
    }
    
    private init() {}
}
