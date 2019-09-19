//
//  AppError.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by God on 9/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
