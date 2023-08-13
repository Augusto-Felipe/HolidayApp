//
//  Alert.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

enum AlertTitle: String {
    case alertButtonTitle = "OK"
    case alertErrorTitle = "Erro"
    case alertErrorMessage = "Ano não suportado."
}

class Alert {
    
    private let controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    public func createAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: AlertTitle.alertButtonTitle.rawValue, style: .cancel) { action in
            completion?()
        }
        alert.addAction(okButton)
        controller?.present(alert, animated: true)
    }
}
