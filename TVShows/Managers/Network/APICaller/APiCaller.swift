    //
    //  APiCaller.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 30/09/21.
    //

import Foundation

class APICaller {
    static let instance = APICaller()
    
    func sendRequest<T: Codable>(witRequest request: URLRequest, completion: @escaping(Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(
            with: request) { data, response, error in
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                      completion(.failure(TVMazeApi.APIError.failedToGetData))
                }
                guard let data = data, error == nil else {
                    completion(.failure(TVMazeApi.APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(TVMazeApi.APIError.failedToGetData))
                }
            }.resume()
    }
    
    func get<T: Codable>(withUrl url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(TVMazeApi.APIError.failedToGetData))
            return
        }
        let request = URLRequest(url: url)
        sendRequest(witRequest: request) { result in
            completion(result)
        }
    }
    
    func post<T: Codable>(withURL url: String, body: T, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(TVMazeApi.APIError.failedToGetData))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(body)
        sendRequest(witRequest: request) { result in
            completion(result)
        }
    }
}
