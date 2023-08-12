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
        
        ServiceManager.shared.request(with: urlString, method: .get, decodeType: [Holiday].self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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

