//  NetworkHelper.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

//NetworkHelper - turns URL into Data
struct NetworkHelper {
	private init(){}
	static let manager = NetworkHelper()
	private let session = URLSession(configuration: .default)
	func performDataTask(with url: URL,
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
}
