//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class ShowAPIClient {
	private init() {}
	static let manager = ShowAPIClient()
	func getShows(from urlStr: String,
								completionHandler: @escaping ([Show])->Void,
								errorHandler: @escaping (AppError)->Void){
		guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
		let completion: (Data)->Void = {(data: Data) in
			do {
				let showInfo = try JSONDecoder().decode([ShowInfo].self, from: data)
				let shows = showInfo.map({$0.show})
//				let shows = showInfo.show
				completionHandler(shows)
			}
			catch let error {
				errorHandler(AppError.codingError(rawError: error))
			}
		}
		NetworkHelper.manager.performDataTask(with: url,
																					completionHandler: completion,
																					errorHandler: errorHandler)
																					//errorHandler: {(print($0))})
	}
}


