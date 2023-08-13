//
//  OnboardingViewControllerScreen.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit
import CLTypingLabel

protocol OnboardingViewControllerScreenProtocol: AnyObject {
    func startTapped()
}

class OnboardingViewControllerScreen: UIView {
    
    private weak var delegate: OnboardingViewControllerScreenProtocol?
    
    public func delegate(delegate: OnboardingViewControllerScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var onboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: OnboardingScreenEnum.onboardingImageName.rawValue)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var appDescriptionLabel: CLTypingLabel = {
        let lb = CLTypingLabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.charInterval = 0.07
        lb.text = OnboardingScreenEnum.onboardingAppDescription.rawValue
        lb.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lb.textColor = UIColor.black
        lb.onTypingAnimationFinished = {
            UIView.animate(withDuration: 1.0) {
                self.descriptionLabel.alpha = 1
            }
        }
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = OnboardingScreenEnum.onboardingDescription.rawValue
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = UIColor.black
        lb.alpha = 0
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var letsStartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(OnboardingScreenEnum.onboardingButtonTitle.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appDarkBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func startButtonTapped() {
        self.delegate?.startTapped()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configSuperView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSuperView() {
        addSubview(onboardImageView)
        addSubview(appDescriptionLabel)
        addSubview(descriptionLabel)
        addSubview(letsStartButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            onboardImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            onboardImageView.heightAnchor.constraint(equalToConstant: 340),
            onboardImageView.widthAnchor.constraint(equalToConstant: 230),
            
            appDescriptionLabel.topAnchor.constraint(equalTo: onboardImageView.bottomAnchor, constant: 30),
            appDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            appDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            
            descriptionLabel.topAnchor.constraint(equalTo: appDescriptionLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            letsStartButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            letsStartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            letsStartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            letsStartButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
