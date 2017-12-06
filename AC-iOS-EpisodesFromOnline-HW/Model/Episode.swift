//  Episode.swift
//  AC-iOS-EpisodesFromOnline-HW
//  Created by Winston Maragh on 12/4/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

struct Episode: Codable {
	let id: Int? //overall episode #
	let name: String
	let season: Int
	let number: Int //episode
//	let airdate: String
//	let airtime: String
//	let airstamp: String
	let runtime: Int
	let image: Image?
	struct Image: Codable {
		let medium: String?
		let original: String?
	}
	let summary: String?
}
