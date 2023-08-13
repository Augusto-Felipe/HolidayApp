//
//  HolidayDetailViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

enum DetailScreenEnum: String {
    case backButtonImageName = "back"
    case navigationTitle = "Detalhes"
    case nameLabelText = "Nome"
    case localNameLabelText = "Nome Local"
    case dateLabelText = "Data"
}

class HolidayDetailViewController: UIViewController {
    
    var holiday: Holiday
    
    init(holiday: Holiday) {
        self.holiday = holiday
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var screen: HolidayDetailViewControllerScreen = {
        let screen = HolidayDetailViewControllerScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override func loadView() {
        self.screen = HolidayDetailViewControllerScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen.delegate(delegate: self)
        configSuperView()
    }
    
    func convertDateToBrazilianFormat(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    public func configSuperView() {
        self.screen.nameDescriptionLabel.text = holiday.name
        self.screen.localNameDescriptionLabel.text = holiday.localName
        if let dateFormated = convertDateToBrazilianFormat(dateString: holiday.date) {
            self.screen.dateDescriptionLabel.text = dateFormated
        }
    }
}

extension HolidayDetailViewController: HolidayDetailViewControllerScreenProtocol {
    func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
 
