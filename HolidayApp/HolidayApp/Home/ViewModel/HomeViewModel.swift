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

class HomeViewModel {
    
    private var holidayList: [Holiday] = []
    
    var delegate: HomeViewModelProtocol?
    
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
            return selectedCountryData["name"]
        } else {
            return CountryData.years[row]
        }
    }
}
