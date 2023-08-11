//
//  HolidayViewModel.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HolidayViewModel: UIView {
    
    var holidayList: [Holiday] = []

    public func sizeForItemAt(collection: UICollectionView) -> CGSize {
        return CGSize(width: collection.bounds.width - 25, height: 100)
    }
    
    public var numberOfItemsInSection: Int {
        return holidayList.count
    }
    
    public func loadCurrentHoliday(indexPath: IndexPath) -> Holiday {
        return holidayList[indexPath.row]
    }
}
