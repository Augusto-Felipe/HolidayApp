//
//  HolidayViewModel.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HolidayViewModel: UIView {
    
    var holidayList: [Holiday]
    
    init(holidayList: [Holiday]) {
        self.holidayList = holidayList
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
