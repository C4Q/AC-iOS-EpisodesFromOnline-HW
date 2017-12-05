//  ShowAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class ShowAPIClient {
	//Singleton
	private init() {}
	static let manager = ShowAPIClient()

	//Method to get Shows
	func getShows(named searchStr: String,
								completionHandler: @escaping ([Show])->Void,
								errorHandler: @escaping (Error)->Void) {
		//update url for search
		let urlStr = "http://api.tvmaze.com/search/shows?q=\(searchStr)"
		//guard for bad url
		guard let url = URL(string: urlStr) else {return}
		//completionHandler
		let completion: (Data)->Void = {(data: Data) in
			do {
				let showInfo = try JSONDecoder().decode([ShowInfo].self, from: data)
				let shows = showInfo.map({$0.show})
				completionHandler(shows)
			}
			catch {
				print(error)
			}
		}
		NetworkHelper.manager.performDataTask(with: url,
																					completionHandler: completion,
																					errorHandler: errorHandler)
																					//errorHandler: {(print($0))})
	}
}


