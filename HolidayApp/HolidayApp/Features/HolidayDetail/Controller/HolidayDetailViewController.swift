//
//  HolidayDetailViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

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
    
    public func configSuperView() {
        self.screen.nameDescriptionLabel.text = holiday.name
        self.screen.localNameDescriptionLabel.text = holiday.localName
        self.screen.dateDescriptionLabel.text = holiday.date
    }
}

extension HolidayDetailViewController: HolidayDetailViewControllerScreenProtocol {
    func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
 
