//
//  OnboardingViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

enum OnboardingScreenEnum: String {
    case onboardingImageName = "onboard"
    case onboardingAppDescription = "Descubra os principais feriados de cada país"
    case onboardingDescription = """
    Com o Holiday App você fica por dentro dos
    principais feriados de mais de 100 países
    diferentes
    """
    case onboardingButtonTitle = "Vamos"
}

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
        self.screen.onboardImageView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) {
            self.screen.onboardImageView.alpha = 1
        }
    }
}

extension OnboardingViewController: OnboardingViewControllerScreenProtocol {
    func startTapped() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
