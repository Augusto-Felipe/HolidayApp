//
//  HomeService.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit
import Alamofire

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
    
    func getHolidayListAlamofire(url: String ,completion: @escaping ([Holiday]?, Error?) -> Void) {
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Holiday].self) { response in
            
            debugPrint(response)
            
            switch response.result {
            case .success(let sucess):
                print("SUCESS -> \(#function)")
                completion(sucess, nil)
            case .failure(let error):
                print("ERROR -> \(#function)")
                completion(nil, error)
            }
        }
    }
}

