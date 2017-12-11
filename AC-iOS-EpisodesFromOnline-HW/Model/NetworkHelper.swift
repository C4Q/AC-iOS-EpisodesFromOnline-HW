//
//  NetworkHelper.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/10/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation
import UIKit

//HTTP
enum HTTPVerb: String {
    case GET //Read
    case POST //Create
    case DELETE //Delete
    case PUT //Update/Replace
    case PATCH //Update/Modify
}

//AppError
enum AppError: Error {
    case badData
    case badURL
    case unauthenticated
    case codingError(rawError: Error)
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}

struct NetworkHelper {
    private init(){}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    //URL
    func performDataTask(withURL url: URL,
                         completionHandler: @escaping (Data)->Void,
                         errorHandler: @escaping (AppError)->Void){
        
        session.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.badData); return}
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
    //URLRequest - just like URL but with metadata attached (eg. username, password, etc)
    func performDataTask(withURLRequest urlRequest: URLRequest,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: urlRequest){(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.badData); return}
                if let error = error {
                    errorHandler(AppError.other(rawError: error))
                }
                completionHandler(data)
            }
            }.resume()
    }
}

class ImageAPIClient {
    //Create a Singleton
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else { errorHandler(AppError.badURL); return}
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {return}
            completionHandler(onlineImage) //call completionHandler
        }
        NetworkHelper.manager.performDataTask(withURL: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
