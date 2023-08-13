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
    private var countryList: [Country] = []
    private var service: HomeService = HomeService()
    
    private weak var delegate: HomeViewModelProtocol?
    
    public func delegate(delegate: HomeViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func getHolidays() -> [Holiday] {
        return holidayList
    }
    
    public func getCountryCode(row: Int) -> String {
        return countryList[row].code
    }
    
    public var numberOfComponents: Int {
        return 2
    }
    
    public var numberOfRowsInComponent: Int {
        return countryList.count
    }
    
    func configPickerViewYears() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let startYear = currentYear - 55
        let endYear = currentYear + 55
        return (startYear...endYear).map { String($0) }
    }
    
    public func titleForRow(pickerView: UIPickerView, row: Int, component: Int) -> String? {
        if component == 0 {
            let selectedCountryData = countryList[row].name
            return selectedCountryData
        } else {
            return configPickerViewYears()[row]
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
    
    public func getDataFromJSON() {
        service.getCountryDataJson { result, error in
            if error != nil {
                
            } else {
                self.countryList = result ?? []
            }
        }
    }
}
