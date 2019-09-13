import Foundation

struct ShowAPIClient {
    private init(){}
    static public func getEpisodes(searchTerm Term: String, completionHandler: @escaping(Result<[Episode], AppError>)-> Void){
        let endPoint = "http://api.tvmaze.com/singlesearch/shows?q=\(Term)&embed=episodes"
        guard let websiteUrl = URL(string: endPoint) else {
            completionHandler(.failure(.badURL("Bad URL")))
            return }
        let request = URLRequest(url: websiteUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response , error) in
            if let data = data{
                do{ let episodes = try JSONDecoder().decode(EmbeddedContent.self,from: data)
                    completionHandler(.success(episodes.episodes))
            } catch{completionHandler(.failure(.decodingError(error)))}
            }
            if let error = error{completionHandler(.failure(.networkError(error)))}
       
        }
        task.resume()
    }
//    private init(){}
    static public func getShow(searchTerm Term: String, completionHandler:
        @escaping(Result<[ShowInfo], AppError>)->Void){
        let endPoint = "http://api.tvmaze.com/search/shows?q=girls"
        guard let websiteUrl = URL(string: endPoint) else {
            completionHandler(.failure(.badURL("Bad URL")))
            return }
        let request = URLRequest(url: websiteUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response , error) in
            if let data = data {
                do {
                    let show = try JSONDecoder().decode([ShowInfo].self,from: data)
                    completionHandler(.success(show))
                } catch{completionHandler(.failure(.decodingError(error)))}
            }
            if let error = error{completionHandler(.failure(.networkError(error)))}
            
        }
        task.resume()
    }
    }


