//
//  HolidayViewController.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 11/08/23.
//

import UIKit

class HolidayViewController: UIViewController {
    
    var holidayList: [Holiday]
    
    private lazy var screen: HolidayScreen = {
        let screen = HolidayScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    init(holidayList: [Holiday]) {
        self.holidayList = holidayList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.screen = HolidayScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.screen.configCollectionView(delegate: self, datasource: self)
    }
    
}

extension HolidayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return holidayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HolidayCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: HolidayCollectionViewCell.identifier, for: indexPath) as? HolidayCollectionViewCell
        cell?.setupCell(holiday: holidayList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 25, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
