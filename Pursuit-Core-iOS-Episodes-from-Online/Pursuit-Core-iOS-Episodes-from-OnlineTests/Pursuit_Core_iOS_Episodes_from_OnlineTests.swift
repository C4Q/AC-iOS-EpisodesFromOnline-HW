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

    func testGetData(){
        //Arrange
        let exampleURLString = "http://api.tvmaze.com/search/shows?q=girls"
        let exp = XCTestExpectation(description: "Valid data is returned.")
        var data = Data()
        
        
        //Act
        
        NetworkHelper.shared.getData(using: exampleURLString) { result in
            switch result{
            case .failure(_):
                break
            case .success(let returnedData):
                data = returnedData
                // Assert
                exp.fulfill()
                XCTAssertNotNil(data, "Data returned with a value of nil.")
            }
        }
        wait(for: [exp], timeout: 10.0)
    }
    
}
