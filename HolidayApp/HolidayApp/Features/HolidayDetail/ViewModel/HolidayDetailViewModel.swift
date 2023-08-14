//
//  HolidayDetailViewModel.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 13/08/23.
//

import UIKit

class HolidayDetailViewModel {
    
    private var holiday: Holiday
    
    init(holiday: Holiday) {
        self.holiday = holiday
    }
    
    public func getHolidayName() -> String {
        return holiday.name
    }
    
    public func getHolidayLocalName() -> String {
        return holiday.localName
    }
    
    public func getHolidayDate() -> String {
        return holiday.date
    }
}
