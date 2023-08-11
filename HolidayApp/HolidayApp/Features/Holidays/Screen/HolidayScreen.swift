//
//  HolidayScreen.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

protocol HolidayScreenProtocol: AnyObject {
    func backTapped()
}

class HolidayScreen: UIView {
    
    var delegate: HolidayScreenProtocol?
    
    public func delegate(delegate: HolidayScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var navigationBarView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLightGreen
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lb.text = "Feriados"
        lb.textColor = UIColor.white
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(HolidayCollectionViewCell.self, forCellWithReuseIdentifier: HolidayCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 0, right: 24)
        layout.scrollDirection = .vertical
        cv.setCollectionViewLayout(layout, animated: false)
        return cv
    }()
    
    public func configCollectionView(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource){
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
    }
    
    @objc func backButtonTapped() {
        self.delegate?.backTapped()
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
        addSubview(navigationBarView)
        navigationBarView.addSubview(navigationTitleLabel)
        navigationBarView.addSubview(backButton)
        addSubview(collectionView)
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
            
            collectionView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
