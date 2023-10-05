//
//  PostService.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import Foundation

class PostService {
    var session: URLSession
    var dataTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchPosts<T: Decodable>(
        url: URL?,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping (Result<T, ServiceError>) -> Void
    ) {
        dataTask?.cancel()
        
        guard let url = url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidUrl))
            }
            return
        }
        
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseStatus))
                }
                return
            }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.dataTaskError(error!.localizedDescription)))
                }
                return
            }
            
            guard let jsonData = data else {
                DispatchQueue.main.async {
                    completion(.failure(.corruptData))
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error.localizedDescription)))
                }
            }
        })
        
        dataTask?.resume()
    }
}
