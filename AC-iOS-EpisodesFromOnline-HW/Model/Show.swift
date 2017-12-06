//  Show.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by Winston Maragh on 12/4/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

struct ShowInfo: Codable {
	let show: Show
}

struct Show: Codable {
	let id: Int //139,
	let name: String // "Girls",
	let rating: Rating?
	let image: Image?
//	let summary: String
}

struct Rating: Codable {
	let average: Float?
}

struct Image: Codable {
	let medium: String
	let original: String
}
