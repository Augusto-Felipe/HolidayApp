//
//  HolidayDetailViewControllerScreen.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

protocol HolidayDetailViewControllerScreenProtocol: AnyObject {
    func backTapped()
}

class HolidayDetailViewControllerScreen: UIView {

    var delegate: HolidayDetailViewControllerScreenProtocol?
    
    public func delegate(delegate: HolidayDetailViewControllerScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var navigationBarView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLightBlue
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: DetailScreenEnum.backButtonImageName.rawValue), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lb.text = DetailScreenEnum.navigationTitle.rawValue
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.textColor = .appLightBlue
        lb.text = DetailScreenEnum.nameLabelText.rawValue
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var localNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.textColor = .appLightBlue
        lb.text = DetailScreenEnum.localNameLabelText.rawValue
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var dateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.textColor = .appLightBlue
        lb.text = DetailScreenEnum.dateLabelText.rawValue
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var localNameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var nameDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var localNameDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var dateDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lb.textColor = UIColor.white
        lb.textAlignment = .left
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configSuperView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonTapped() {
        self.delegate?.backTapped()
    }
    
    private func configSuperView() {
        addSubview(navigationBarView)
        navigationBarView.addSubview(navigationTitleLabel)
        navigationBarView.addSubview(backButton)
        addSubview(nameLabel)
        addSubview(nameView)
        nameView.addSubview(nameDescriptionLabel)
        addSubview(localNameLabel)
        addSubview(localNameView)
        localNameView.addSubview(localNameDescriptionLabel)
        addSubview(dateLabel)
        addSubview(dateView)
        dateView.addSubview(dateDescriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 110),
            
            navigationTitleLabel.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor),
            navigationTitleLabel.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor, constant: 20),
            
            backButton.centerYAnchor.constraint(equalTo: navigationTitleLabel.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            nameView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            nameView.heightAnchor.constraint(equalToConstant: 44),
            
            nameDescriptionLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            nameDescriptionLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            
            localNameLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 12),
            localNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            localNameView.topAnchor.constraint(equalTo: localNameLabel.bottomAnchor, constant: 8),
            localNameView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            localNameView.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            localNameView.heightAnchor.constraint(equalTo: nameView.heightAnchor),
            
            localNameDescriptionLabel.centerXAnchor.constraint(equalTo: localNameView.centerXAnchor),
            localNameDescriptionLabel.centerYAnchor.constraint(equalTo: localNameView.centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: localNameView.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            dateView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            dateView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            dateView.heightAnchor.constraint(equalTo: nameView.heightAnchor),
            
            dateDescriptionLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateDescriptionLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
        ])
    }
}
