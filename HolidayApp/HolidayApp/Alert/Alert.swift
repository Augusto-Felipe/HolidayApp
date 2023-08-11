//
//  Alert.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class Alert {
    
    private let controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    public func createAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { action in
            completion?()
        }
        alert.addAction(okButton)
        controller?.present(alert, animated: true)
    }
}
