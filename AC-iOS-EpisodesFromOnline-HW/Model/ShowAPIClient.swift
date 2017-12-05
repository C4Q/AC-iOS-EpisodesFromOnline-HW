//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class ShowAPIClient {
	//Singleton
	private init() {}
	static let manager = ShowAPIClient()

	func getShows(from urlStr: String,
								completionHandler: @escaping ([Show])-> Void,
								errorHandler: @escaping (AppError) -> Void) {
		//guard for bad url
		guard let url = URL(string: urlStr) else {errorHandler(.badURL); return}
		//completionHandler
		let completion: (Data) -> Void = {(data: Data) in
			do {
				let shows = try JSONDecoder().decode([Show].self, from: data)
				completionHandler(shows)
			}
			catch {
				errorHandler(.couldNotParseJSON(rawError: error))
			}
		}
		NetworkHelper.manager.performDataTask(with: url,
																					completionHandler: completion,
																					errorHandler: errorHandler)
	}
}
