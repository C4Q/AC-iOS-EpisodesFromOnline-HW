//
//  AppError.swift
//  EpisodesFromOnline
//
//  Created by Pursuit on 9/10/19.
//

import Foundation

enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case badHTTPResponse
    case badUrl
    case notFound //404 status code
    case unauthorized //403 and 401 status code
    case badImageData
    case other(errorDescription: String)
}
