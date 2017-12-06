//
//  AppError.swift
//  AC-iOS-EpisodesFromOnline-HW
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case badStatusCode(num: Int)
    case other(rawError: Error)
}
