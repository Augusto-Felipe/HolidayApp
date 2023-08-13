//
//  ViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

enum PickerViewKey: String {
    case textColorKey = "textColor"
}

enum DictionaryKeys: String {
    case code = "code"
    case name = "name"
}

enum HomeScreenEnum: String {
    case backgroundImageName = "background"
    case appLogoImageName = "logo2"
    case searchButtonTitle = "Pesquisar"
}

class HomeViewController: UIViewController {
    
    var selectedCountryCode: String = ""
    var selectedYear: String = ""
    
    private lazy var screen: HomeScreen = {
        let screen = HomeScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    private var viewModel: HomeViewModel = HomeViewModel()
    private var alert: Alert?
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getDataFromJSON()
        self.alert = Alert(controller: self)
        self.viewModel.delegate(delegate: self)
        self.screen.delegate(delegate: self)
        self.screen.configPickerViewDelegate(dataSource: self, delegate: self)
        configureInitialSelectedValues()
    }
    
    func configPickerViewYears() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let startYear = currentYear - 55
        let endYear = currentYear + 55
        return (startYear...endYear).map { String($0) }
    }
    
    func configureInitialSelectedValues() {
        let initialCountryRow = screen.countryPickerView.selectedRow(inComponent: 0)
        selectedCountryCode = viewModel.getCountryCode(row: initialCountryRow)
        
        let initialYearRow = screen.yearPickerView.selectedRow(inComponent: 0)
        selectedYear = viewModel.configPickerViewYears()[initialYearRow]
    }
}

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRowsInComponent
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.titleForRow(pickerView: pickerView, row: row, component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedCountryCode = viewModel.getCountryCode(row: row)
        case 1:
            selectedYear = viewModel.configPickerViewYears()[row]
        default:
            break
        }
    }
}

extension HomeViewController: HomeScreenProtocol {
    func searchTapped() {
        viewModel.fetchRequest(countryCode: selectedCountryCode, year: selectedYear, requestType: .URLSession)
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        let vc = HolidayViewController()
        vc.viewModel.holidayList = viewModel.getHolidays()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func error() {
        self.alert?.createAlert(title: AlertTitle.alertErrorTitle.rawValue, message: AlertTitle.alertErrorMessage.rawValue)
    }
}

