//
//  NetworkHelper.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class NetworkHelper {
    
    private init(){}
    
    static let manager = NetworkHelper()
    
    private let mySession = URLSession(configuration: .default)
    
    func performDataTask(with url: URL,
                         completionHandler: @escaping (Data) -> Void,
                         errorHandler: @escaping (Error) -> Void){
        
        mySession.dataTask(with: url){(data: Data?,
                                        response: URLResponse?,
                                        error: Error?) in
            //make sure you have data
            guard let data = data else {return}
             /// have to make sure to put back on main thread because data will change UI Elements
            //Dispatch Queue
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(error)
                    return
                }
                completionHandler(data)
            }
            }.resume()
    }
}
