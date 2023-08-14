//
//  UIView+Extension.swift
//  CountryApp
//
//  Created by Felipe Augusto Correia on 28/06/23.
//

import Foundation
import UIKit

extension UIView {    
    func setCardShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
    }
}
