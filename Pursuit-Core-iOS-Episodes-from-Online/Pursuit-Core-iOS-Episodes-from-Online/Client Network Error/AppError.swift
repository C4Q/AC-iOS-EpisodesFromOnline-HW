//
//  AppError.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Liana Norman on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badDataError
    case badDecoderError
    case badJSONError
    case networkError
    case badHTTPResponse
    case badURL
    case noDataError
    // This is a 404 status code
    case notFound
    // Below is 401 and 403
    case unauthorized
    case badImageError
    case badImageData
    case other(rawError: String)
}
