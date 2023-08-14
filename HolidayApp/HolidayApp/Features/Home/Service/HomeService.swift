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
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard let dataResult = data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    do {
                        let holidayData: [Holiday] = try JSONDecoder().decode([Holiday].self, from: dataResult)
                        print("SUCESS -> \(#function)")
                        completion(.success(holidayData))
                    } catch {
                        print("ERROR -> \(#function)")
                        completion(.failure(.decodingError(error)))
                    }
                } else {
                    print("ERROR -> \(#function)")
                    completion(.failure(.invalidResponse))
                }
            }
        }
        
        task.resume()
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
    
    func getCountryDataJson(completion: @escaping ([Country]?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: "CountriesData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let countriesData: [Country] = try JSONDecoder().decode([Country].self, from: data)
                completion(countriesData, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

