//
//  AllShowsModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Phoenix McKnight on 9/10/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

//class ArtistApiHelper {
//    static let shared = AllShowsAPIHelper()
//    private init () {}
//    
//    
//    
//    func getArtist(name:String?,completionHandler: @escaping(Result<[TrackList],AppError>) -> ()) {
//        var urlStr = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=kanye&page_size=100&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
//        if let artistName = name{
//            let newArtistName = artistName.replacingOccurrences(of: " ", with: "-")
//            
//            urlStr = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=\(newArtistName)&page_size=100&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
//        }
//        NetworkManager.shared.fetchData(urlString: urlStr) { (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(error))
//            case .success(let data):
//                do { let artistName = try JSONDecoder().decode(ArtistWrapper.self, from: data)
//                    completionHandler(.success(artistName.message.body.track_list))
//                } catch {
//                    completionHandler(.failure(.networkError))
//                }
//            }
//        }
//    }
//}
//
//
//
