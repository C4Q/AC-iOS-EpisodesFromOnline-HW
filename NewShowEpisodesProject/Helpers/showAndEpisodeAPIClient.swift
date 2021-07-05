//
//  showAndEpisodeAPIClient.swift

import Foundation

struct ShowAPIClient {
//    private init(){}
    static let  shared = ShowAPIClient()
     public func getEpisodes(searchTerm Term: String, completionHandler: @escaping(Result<[EpisodeModel], AppError>)-> Void){
        let endPoint = "http://api.tvmaze.com/shows/\(Term)/episodes"
        guard let websiteUrl = URL(string: endPoint) else {
            completionHandler(.failure(.badURL("Bad URL")))
            return }
        let request = URLRequest(url: websiteUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response , error) in
            if let data = data{
                do{
                    let episodes = try JSONDecoder().decode([EpisodeModel].self,from: data)
                    completionHandler(.success(episodes))
            } catch{completionHandler(.failure(.decodingError(error)))}
            }
            if let error = error{completionHandler(.failure(.networkError(error)))}
       
        }
        task.resume()
    }
//    private init(){}
//    static let  shared = ShowAPIClient()
     public func getShow(searchTerm Term: String, completionHandler:
        @escaping(Result<[ShowModel], AppError>)->Void){
        let endPoint = "http://api.tvmaze.com/search/shows?q=\(Term.lowercased())"
        guard let websiteUrl = URL(string: endPoint) else {
            completionHandler(.failure(.badURL("Bad URL")))
            return }
        let request = URLRequest(url: websiteUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response , error) in
            if let data = data {
                do {
                    let show = try JSONDecoder().decode([ShowModel].self,from: data)
                    completionHandler(.success(show))
                } catch{completionHandler(.failure(.decodingError(error)))}
            }
            if let error = error{completionHandler(.failure(.networkError(error)))}
            
        }
        task.resume()
    }
    }


