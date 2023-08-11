//
//  HomeService.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

enum NetWorkError: Error {
    case invalidURL(url: String)
    case noData
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
}

class HomeService: NSObject {
    
    func getHolidayList(urlString: String, completion: @escaping (Result<[Holiday], NetWorkError>) -> Void) {
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let holiday: [Holiday] = try JSONDecoder().decode([Holiday].self, from: dataResponse)
                    completion(.success(holiday))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}

