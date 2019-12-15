//
//  NetworkError.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/7/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case badURL(String)
    case invalidData
    case noResponse
    case networkClientError(Error)
    case badStatusCode(Int)
    case decodingError(Error)
}
