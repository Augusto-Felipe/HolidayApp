//
//  ViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var screen: HomeScreen = {
        let screen = HomeScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

