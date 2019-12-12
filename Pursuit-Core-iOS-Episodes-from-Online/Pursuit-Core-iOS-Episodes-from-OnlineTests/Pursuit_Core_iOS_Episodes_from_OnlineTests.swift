//
//  Pursuit_Core_iOS_Episodes_from_OnlineTests.swift
//  Pursuit-Core-iOS-Episodes-from-OnlineTests
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import XCTest
@testable import Pursuit_Core_iOS_Episodes_from_Online

class Pursuit_Core_iOS_Episodes_from_OnlineTests: XCTestCase {
    

    func testShowModel() {
        var shows = [ShowWrapper]()
        let urlString = "https://api.tvmaze.com/search/shows?q=girls"
        let id = 139
        
        let exp = XCTestExpectation(description: "JSON decoded successfully.")
        
        GenericCodingService.manager.decodeJSON([ShowWrapper].self, with: urlString) { (result) in
            switch result {
            case .failure(let error):
                print("Error occured decoding: \(error)")
            case .success(let showsFromAPI):
                shows = showsFromAPI
                XCTAssertEqual(id, shows[0].show.id)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 20.0)
    }

}
