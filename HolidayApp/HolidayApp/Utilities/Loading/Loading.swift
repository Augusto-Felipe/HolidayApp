//
//  Loading.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 14/08/23.
//

import UIKit

class Loading {
    
    private var viewController: UIViewController
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private lazy var messageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .gray
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private func configSuperView() {
        containerView.addSubview(activityIndicator)
        containerView.addSubview(messageLabel)
        viewController.view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
        ])
    }
    
    public func showLoading(message: String? = nil) {
        configSuperView()
        setupConstraints()
        messageLabel.text = message
        messageLabel.isHidden = message == nil
        activityIndicator.startAnimating()
    }
    
    public func hideLoading() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
