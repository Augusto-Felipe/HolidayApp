//
//  HomeViewModel.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func success()
    func error()
}

enum RequestType {
    case URLSession
    case Alamofire
}

class HomeViewModel {
    
    private var holidayList: [Holiday] = []
    private var service: HomeService = HomeService()
    
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func getHolidays() -> [Holiday] {
        return holidayList
    }
    
    public var numberOfComponents: Int {
        return 2
    }
    
    public var numberOfRowsInComponent: Int {
        return CountryData.countriesData.count
    }
    
    public func titleForRow(pickerView: UIPickerView, row: Int, component: Int) -> String? {
        if component == 0 {
            let selectedCountryData = CountryData.countriesData[row]
            return selectedCountryData[DictionaryKeys.name.rawValue]
        } else {
            return CountryData.years[row]
        }
    }
    
    public func fetchRequest(countryCode: String, year: String, requestType: RequestType) {
        
        switch requestType {
        case .Alamofire:
            service.getHolidayListAlamofire(year: year, countryCode: countryCode) { holidayList, error in
                if error != nil {
                    self.delegate?.error()
                } else {
                    self.holidayList = holidayList ?? []
                    self.delegate?.success()
                }
            }
            
        case .URLSession:
            service.getHolidayList(year: year, countryCode: countryCode) { result in
                switch result {
                case .success(let holiday):
                    self.holidayList = holiday
                    self.delegate?.success()
                case.failure(_):
                    self.delegate?.error()
                }
            }
        }
    }
}
