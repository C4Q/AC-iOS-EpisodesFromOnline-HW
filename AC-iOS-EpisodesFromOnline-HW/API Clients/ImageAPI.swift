//
//  ImageAPI.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit


///CONFORM TO IMPORT UIKIT
class ImageAPI{
    
    private init() {}
    static let manager = ImageAPI()
    
    //parameters: urlStr, completionHandler and errorHandler
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        //make sure you can turn the the string into a url
        guard let url = URL(string: urlStr) else {return}
        
        let completion = {(data: Data) in
            //make sure you can get an online image from the data
            guard let onlineImage = UIImage(data: data) else {return}
            completionHandler(onlineImage)
        }
        //Network call to perform task of getting necesary data from online or catch any errors
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}



