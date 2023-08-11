//
//  HomeScreen.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

protocol HomeScreenProtocol: AnyObject {
    func searchTapped()
}

class HomeScreen: UIView {
    
    var delegate: HomeScreenProtocol?
    
    public func delegate(delegate: HomeScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    lazy var countryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.layer.cornerRadius = 12
#warning("create color extension")
        pickerView.backgroundColor = .appLightGreen
        pickerView.setValue(UIColor.white, forKey: "textColor")
        return pickerView
    }()
    
    lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.layer.cornerRadius = 12
#warning("create color extension")
        pickerView.backgroundColor = .appLightGreen
        pickerView.setValue(UIColor.white, forKey: "textColor")
        return pickerView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Vamos", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
#warning("create color extension")
        button.backgroundColor = .appLightSalmon
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func searchButtonTapped() {
        self.delegate?.searchTapped()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        addSubview(backgroundImageView)
        addSubview(appLogoImageView)
        addSubview(countryPickerView)
        addSubview(searchButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            appLogoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 170),
            appLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            appLogoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 130),
            
            countryPickerView.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 20),
            countryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countryPickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countryPickerView.heightAnchor.constraint(equalToConstant: 90),
            
            searchButton.topAnchor.constraint(equalTo: countryPickerView.bottomAnchor, constant: 40),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
