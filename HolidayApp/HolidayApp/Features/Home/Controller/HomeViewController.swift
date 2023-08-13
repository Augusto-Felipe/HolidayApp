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
        self.alert = Alert(controller: self)
        self.viewModel.delegate(delegate: self)
        self.screen.delegate(delegate: self)
        self.screen.configPickerViewDelegate(dataSource: self, delegate: self)
        configureInitialSelectedValues()
    }
    
    func configureInitialSelectedValues() {
        let initialCountryRow = screen.countryPickerView.selectedRow(inComponent: 0)
        selectedCountryCode = CountryData.countriesData[initialCountryRow][DictionaryKeys.code.rawValue] ?? ""
        
        let initialYearRow = screen.yearPickerView.selectedRow(inComponent: 0)
        selectedYear = CountryData.years[initialYearRow]
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
        if component == 0 {
            selectedCountryCode = CountryData.countriesData[row][DictionaryKeys.code.rawValue] ?? ""
        } else if component == 1 {
            selectedYear = CountryData.years[row]
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

