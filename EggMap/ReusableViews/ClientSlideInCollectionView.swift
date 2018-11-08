//
//  SlideInFromLeftCollectionView.swift
//  EggMap
//
//  Created by Mei on 2018-10-15.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ClientSlideInCollectionView: UIView {

    let cellId = "cellId"

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ClientSlideUpViewCell.self, forCellWithReuseIdentifier: cellId)
        setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.fillSuperview()
    }

}

extension ClientSlideInCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClientSlideUpViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: ScreenSize.height * 0.075)
    }


}

