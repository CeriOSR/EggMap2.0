//
//  ClientSlideUpView.swift
//  EggMap
//
//  Created by Mei on 2018-10-10.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ClientSlideUpView: UIView {
    
//    let cellId = "cellId"
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: self.frame, collectionViewLayout: layout)
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
    
    
    static weak var shared : ClientSlideUpView?
    var delegate : handleViewButtonsDelegate?
    
    //dummy button
    lazy var directionButton: UIButton = {
        let button = UIButton(type: .system)
        //if the location is a store, title = "Direction" if the location is an agent, title = "Contact Agent"
//        button.setTitle("Direction", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleContactAgentButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let locationTypeImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysTemplate)
        return img
    }()
    
    let locationNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "ABCDEFG Supermarket"
        return lbl
    }()
    
    let datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = .white
        return dp
    }()
    
    var starRating = FiveStarRatingNonInteractiveImage(frame: CGRect(x: 0, y: 0, width: CGFloat((5 * kStarSize) + (4 * kSpacing)), height: CGFloat(kStarSize) ))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        collectionView.register(ClientSlideUpViewCell.self, forCellWithReuseIdentifier: cellId)
        self.clipsToBounds = true
        setupSlideUpView()
        ClientSlideUpView.shared = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSlideUpView()
    }
    
    private func setupSlideUpView() {
//        addSubview(collectionView)
//        collectionView.backgroundColor = .white
//        collectionView.fillSuperview()
        starRating.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(locationNameLabel)
        addSubview(locationTypeImage)
        addSubview(starRating)
        addSubview(directionButton)
        addSubview(datePicker)
        
        locationTypeImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.02, leftConstant: ScreenSize.width * 0.05, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.height * 0.1, heightConstant: ScreenSize.height * 0.1)
        
        locationNameLabel.anchor(locationTypeImage.topAnchor, left: locationTypeImage.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 6, bottomConstant: 0, rightConstant: ScreenSize.width * 0.05, widthConstant: 0, heightConstant: ScreenSize.height * 0.06)
        
        starRating.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 0).isActive = true
        starRating.leftAnchor.constraint(equalTo: locationTypeImage.rightAnchor, constant: 6).isActive = true
        
        directionButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.height * 0.15).isActive = true
        directionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        directionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        directionButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        //date picker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: directionButton.topAnchor).isActive = true
        
    }
    
    @objc func handleContactAgentButtonPressed() {
        delegate?.handleContactButtonPressed(sender: directionButton)
    }
    
}

protocol handleViewButtonsDelegate {
    func handleContactButtonPressed(sender: UIButton)
}

//extension ClientSlideUpView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ClientSlideUpViewCell
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: ScreenSize.height * 0.075)
//    }
//}
