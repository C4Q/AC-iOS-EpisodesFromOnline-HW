//  AppError.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by Winston Maragh on 12/4/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

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
