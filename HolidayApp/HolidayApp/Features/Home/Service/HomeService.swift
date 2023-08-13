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
    
    func getHolidayList(year: String, countryCode: String, completion: @escaping (Result<[Holiday], NetWorkError>) -> Void) {
        let urlString: String = "https://date.nager.at/api/v3/publicholidays/\(year)/\(countryCode)"
        
        ServiceManager.shared.request(with: urlString, method: .get, decodeType: [Holiday].self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getHolidayListAlamofire(year: String, countryCode: String, completion: @escaping ([Holiday]?, Error?) -> Void) {
        let urlString: String = "https://date.nager.at/api/v3/publicholidays/\(year)/\(countryCode)"
        
        AF.request(urlString, method: .get).validate().responseDecodable(of: [Holiday].self) { response in
            
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

