//
//  Network Helper.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/3/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class NetworkHelper {
    //Make it so we can't make NetworkHelpers outside this class
    private init() {}
    
    //Create a class property that we will use to get to instance methods
    static let manager = NetworkHelper()
    
    //Create a default URLSession
    let urlSession = URLSession(configuration: .default)
    
    //Give the manager an instance method that takes a URL, completion handler and error handler.  After getting data from the URL, it runs the completion handler.
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((AppError) -> Void)) {
        
        //Create a dataTask
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                
                //Ensure the data is valid
                guard let data = data else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    errorHandler(AppError.badStatusCode)
                    return
                }
                
                //Handle any errors
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        errorHandler(AppError.noInternetConnection)
                        return
                    }
                    else {
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                //Input the data into the completion handler
                completionHandler(data)
            }
            //resume() starts the data task.  Without out, our data task will not run.
            }.resume()
    }
}
