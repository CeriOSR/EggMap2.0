//
//  ClientProfileView.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-24.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ClientProfileView: UIView {
    
    let localizer = LocalizedPListStringGetter()
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = (ScreenSize.width * 0.25) / 2
        image.image = UIImage(named: "Cartoon Egg")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(self.localizer.parseLocalizable().editProfile?.value, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        button.layer.cornerRadius = ScreenSize.width * 0.01
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleEditProfileTapped),   for: .touchUpInside)
        return button
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = "Longassnamehere Longasslastnamehere"
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = self.localizer.parseLocalizable().email?.value
        return label
    }()
    
    let clientEmailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = "Longassnamehere@Longasslastnamehere.com"
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = self.localizer.parseLocalizable().phone?.value
        return label
    }()
    
    let clientPhoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = "1-999-999-9999"
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = self.localizer.parseLocalizable().address?.value
        return label
    }()
    
    let clientAddressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .red
        label.text = "12345 Longassnamehere Street Longasslastnamehere City, BC, V3X 1Z1"
        return label
    }()
    
    
    let grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let grayLine2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let grayLine3: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let grayLine4: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(profileImageView)
        self.addSubview(profileNameLabel)
        self.addSubview(editProfileButton)
        self.addSubview(grayLine)
        self.addSubview(grayLine2)
        self.addSubview(grayLine3)
        self.addSubview(grayLine4)
        self.addSubview(emailLabel)
        self.addSubview(clientEmailLabel)
        self.addSubview(phoneLabel)
        self.addSubview(clientPhoneLabel)
        self.addSubview(addressLabel)
        self.addSubview(clientAddressLabel)
        
        profileImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.04, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.width * 0.25)
        
        profileNameLabel.anchor(profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.width * 0.02, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.07)
        
        editProfileButton.anchor(profileImageView.topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.05, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.05, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        grayLine.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.25, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: ScreenSize.height * 0.003)
        
        grayLine2.anchor(grayLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.15, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: ScreenSize.height * 0.003)
        
        grayLine3.anchor(grayLine2.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.15, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: ScreenSize.height * 0.003)
        
        grayLine4.anchor(grayLine3.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.25, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: ScreenSize.height * 0.003)
        
        setupSecondSection(line: grayLine)
        setupThirdSection(line: grayLine2)
        setupFourthSection(line: grayLine3)
        
    }
    
    fileprivate func setupSecondSection(line: UIView) {
        emailLabel.anchor(line.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.017, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        clientEmailLabel.anchor(emailLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.019, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.07)
    }
    
    fileprivate func setupThirdSection(line: UIView) {
        phoneLabel.anchor(line.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.017, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        clientPhoneLabel.anchor(phoneLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.019, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.07)
    }
    
    fileprivate func setupFourthSection(line: UIView) {
        addressLabel.anchor(line.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.017, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        clientAddressLabel.anchor(addressLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.019, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.15)
    }
    
    @objc func handleEditProfileTapped() {
        print("Edit client profile pressed.")
    }
    
}
