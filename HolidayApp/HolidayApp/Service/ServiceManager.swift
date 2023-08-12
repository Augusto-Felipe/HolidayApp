//
//  ServiceManager.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 12/08/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkLayer {
    var session: URLSession { get }
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T, NetWorkError>) -> Void)
}

class ServiceManager: NetworkLayer {
    
    static var shared: ServiceManager = ServiceManager()
    
    var session: URLSession = URLSession.shared
    
    func request<T>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T, NetWorkError>) -> Void) where T : Decodable {
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(.networkFailure(error)))
                    return
                }
                
                guard let dataResponse = data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object: T = try decoder.decode(T.self, from: dataResponse)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}