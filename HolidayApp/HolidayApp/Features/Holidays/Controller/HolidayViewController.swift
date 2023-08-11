//
//  HolidayViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HolidayViewController: UIViewController {
    
    var viewModel: HolidayViewModel = HolidayViewModel()
    
    private lazy var screen: HolidayScreen = {
        let screen = HolidayScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.screen = HolidayScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.screen.delegate(delegate: self)
        self.screen.configCollectionView(delegate: self, datasource: self)
    }
}

extension HolidayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HolidayCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: HolidayCollectionViewCell.identifier, for: indexPath) as? HolidayCollectionViewCell
        cell?.setupCell(holiday: viewModel.loadCurrentHoliday(indexPath: indexPath))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItemAt(collection: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HolidayViewController: HolidayScreenProtocol {
    func backTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
