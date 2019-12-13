//
//  JSONHelper.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class GenericCodingService {
    
    static let manager = GenericCodingService()
    
    func decodeJSON<T: Decodable>(_ objectType: T.Type, with urlString: String, completionHandler: @escaping (Result<T, AppError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL(urlString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(model))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    private init() {}
}


