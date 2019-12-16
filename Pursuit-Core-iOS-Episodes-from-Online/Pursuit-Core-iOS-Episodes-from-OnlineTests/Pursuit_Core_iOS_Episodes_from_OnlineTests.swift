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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndPoint() {
        //arrange
        //make this string url friendly
        let searchQuery = "a"
        let endPointURLString = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        guard let url = URL(string: endPointURLString) else {
            
            return
        }
        let urlRequest = URLRequest(url: url)
        let exp = XCTestExpectation(description: "searches found")
        
        //act
        NetworkHelper.shared.performDataTask(with: urlRequest) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("App Err: \(appError)")
            case .success(let data):
                exp.fulfill()
                //assert
                XCTAssertGreaterThan(data.count, 10000, "Data should be greater than \(data.count)")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

    func testGetShows(){
        //arrange
        let searchQuery = "a"
        let exp = XCTestExpectation(description: "searches found")
        var showsArr = [Show]()
        let expectedShows = 10
        var givenShows = Int()
        
        //act
        TVMazeAPIClient.fetchTVShows(searchQuery: searchQuery) { (result) in
            switch result{
            case.failure(let appError):
                fatalError("\(appError)")
            case .success(let shows):
                showsArr = shows
                givenShows = showsArr.count
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
        //assert
        XCTAssertEqual(expectedShows, givenShows, "Expected \(expectedShows) shows, instead of \(givenShows)")
    }
    func testGetEpisodes(){
        //arrange
            let searchQuery = 4379
            let exp = XCTestExpectation(description: "searches found")
            var episodesArr = [Episode]()
            let expectedEpisode = 108
            var givenEpisodes = Int()
            
            //act
            TVMazeAPIClient.fetchEpisodes(episodeNumber: searchQuery) { (result) in
                switch result{
                case.failure(let appError):
                    fatalError("\(appError)")
                case .success(let episodes):
                    episodesArr = episodes
                    givenEpisodes = episodesArr.count
                    exp.fulfill()
                }
            }
            wait(for: [exp], timeout: 5.0)
            //assert
            XCTAssertEqual(expectedEpisode, givenEpisodes, "Expected \(expectedEpisode) shows, instead of \(givenEpisodes)")
    }

}
