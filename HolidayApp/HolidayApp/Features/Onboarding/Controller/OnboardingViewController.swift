//
//  OnboardingViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var screen: OnboardingViewControllerScreen = {
        let screen = OnboardingViewControllerScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override func loadView() {
        self.screen = OnboardingViewControllerScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen.delegate(delegate: self)
    }
}

extension OnboardingViewController: OnboardingViewControllerScreenProtocol {
    func startTapped() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
