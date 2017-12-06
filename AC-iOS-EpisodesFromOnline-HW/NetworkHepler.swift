//
//  NetworkHepler.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by Masai Young on 11/29/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    enum State {
        case loading
        case complete
        case incomplete
    }
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
            }
            }.resume()
    }
}

struct SearchAPIClient {
    private init() {}
    static let manager = SearchAPIClient()
    func getSearchResults(from urlStr: String, completionHandler: @escaping ([SearchResult]) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode([SearchResult].self, from: data)
                completionHandler(results)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

struct EpisodeAPIClient {
    private init() {}
    static let manager = EpisodeAPIClient()
    func getEpisodes(from urlStr: String, completionHandler: @escaping ([Episode]) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                completionHandler(episodes)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}

struct ImageDownloader {
    private init() {}
    static let manager = ImageDownloader()
    func getImage(from urlStr: String, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping () -> Void) {
        // MARK: - Downloads images async
        if let albumURL = URL(string: urlStr) {
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        completionHandler(data)
                    }
                } else {
                    DispatchQueue.main.async {
                        errorHandler()
                    }
                }
            }
        }
    }
}







