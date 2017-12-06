//  ImageAPIClient.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by Winston Maragh on 12/4/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation
import UIKit

class ImageAPIClient {
	//Singleton
	private init() {}
	static let manager = ImageAPIClient()
	func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (AppError) -> Void) {

		//guard for URL not nil
		guard let url = URL(string: urlStr) else {
			errorHandler(.badURL)
			return
		}

		//Call completionHandler
		let completion: (Data) -> Void = {(data: Data) in
			guard let onlineImage = UIImage(data: data) else {
				return
			}
			completionHandler(onlineImage) //call completionHandler
		}

		//call NetworkHelper
		NetworkHelper.manager.performDataTask(with: url,
																					completionHandler: completion,
																					errorHandler: errorHandler)
	}
}
