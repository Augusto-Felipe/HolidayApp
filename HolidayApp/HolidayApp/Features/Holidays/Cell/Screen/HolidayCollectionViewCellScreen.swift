//
//  HolidayCollectionViewCellScreen.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HolidayCollectionViewCellScreen: UIView {
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 22
        view.backgroundColor = .appDarkBlue
        view.setCardShadow()
        return view
    }()
    
    lazy var holidayNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lb.textColor = .white
        lb.textAlignment = .left
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addElements() {
        addSubview(cardView)
        cardView.addSubview(holidayNameLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            
            holidayNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            holidayNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            holidayNameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
        ])
    }
}
