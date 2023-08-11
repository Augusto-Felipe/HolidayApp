//
//  ViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

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
        selectedCountryCode = CountryData.countriesData[initialCountryRow]["code"] ?? ""
        
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
            selectedCountryCode = CountryData.countriesData[row]["code"] ?? ""
        } else if component == 1 {
            selectedYear = CountryData.years[row]
        }
    }
}

extension HomeViewController: HomeScreenProtocol {
    func searchTapped() {
        viewModel.fetchRequest(countryCode: selectedCountryCode, year: selectedYear)
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        
    }
    
    func error() {
        self.alert?.createAlert(title: "Erro", message: "Ano não suportado.")
    }
}

