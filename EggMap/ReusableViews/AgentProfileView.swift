//
//  AgentProfileView.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-24.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AgentProfileView: UIView {
    
    let localizer = LocalizedPListStringGetter()
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(self.localizer.parseLocalizable().editProfile?.value, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        button.layer.cornerRadius = ScreenSize.width * 0.01
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self.localizer.parseLocalizable().location?.value
        return label
    }()
    
    let locationView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self.localizer.parseLocalizable().status?.value
        return label
    }()
    
    lazy var statusSegCon: UISegmentedControl = {
        let segCon = UISegmentedControl(items: [self.localizer.parseLocalizable().available?.value ?? "Available", self.localizer.parseLocalizable().unavailable?.value ?? "Unavailable"])
        segCon.isEnabled = true
        segCon.selectedSegmentIndex = 0
        return segCon
    }()
    
    lazy var hoursLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self.localizer.parseLocalizable().status?.value
        return label
    }()
    
    lazy var editHoursButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(self.localizer.parseLocalizable().editHours?.value, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        button.layer.cornerRadius = ScreenSize.width * 0.01
        button.layer.masksToBounds = true
        return button
    }()
    
    let hoursView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    //--------------------Profile view
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.cornerRadius = (ScreenSize.width * 0.25) / 2
        image.layer.masksToBounds = true
        image.image = UIImage(named: "Cartoon Egg")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    //--------------------
    
    //--------------------location view
    
    lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().tapHere?.value
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let locationImgView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var agentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //            label.backgroundColor = .red
        label.text = self.localizer.parseLocalizable().tapHere?.value
        return label
    }()
    //--------------------
    
    //--------------------Hours View
    lazy var monLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().monday?.value
        return label
    }()
    
    lazy var tuesLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().tuesday?.value
        return label
    }()
    
    lazy var wedLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().wednesday?.value
        return label
    }()
    
    lazy var thursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().thursday?.value
        return label
    }()
    
    lazy var friLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().friday?.value
        return label
    }()
    
    lazy var satLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().saturday?.value
        return label
    }()
    
    lazy var sunLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().sunday?.value
        return label
    }()
    
    lazy var monHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var tuesHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var wedHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var thursHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var friHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var satHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    
    lazy var sunHoursLbl: UILabel = {
        let label = UILabel()
        label.text = self.localizer.parseLocalizable().close?.value
        return label
    }()
    //--------------------
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProfileView() {
        
        
        
        profileView.addSubview(profileImageView)
        profileView.addSubview(profileNameLabel)
        profileView.addSubview(phoneLabel)
        profileView.addSubview(emailLabel)
        
        profileImageView.anchor(profileView.topAnchor, left: profileView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.04, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.width * 0.25)
        
        profileNameLabel.anchor(profileView.topAnchor, left: nil, bottom: nil, right: profileView.rightAnchor, topConstant: ScreenSize.height * 0.04, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: ScreenSize.width * 0.5, heightConstant: ScreenSize.height * 0.045)
        
        phoneLabel.anchor(profileNameLabel.bottomAnchor, left: nil, bottom: nil, right: profileView.rightAnchor, topConstant: ScreenSize.height * 0.001, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: ScreenSize.width * 0.5, heightConstant: ScreenSize.height * 0.03)
        
        emailLabel.anchor(phoneLabel.bottomAnchor, left: nil, bottom: nil, right: profileView.rightAnchor, topConstant: ScreenSize.height * 0.001, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: ScreenSize.width * 0.5, heightConstant: ScreenSize.height * 0.045)
    }
    
    func setupViews() {
        
        addSubview(profileView)
        addSubview(editProfileButton)
        addSubview(locationLabel)
        addSubview(locationView)
        addSubview(statusLabel)
//        addSubview(statusImgView)
        addSubview(statusSegCon)
        addSubview(hoursLabel)
        addSubview(editHoursButton)
        addSubview(hoursView)
        
        profileView.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.17)
        
        setupProfileView()
        
        editProfileButton.anchor(profileView.bottomAnchor, left: nil, bottom: nil/*locationLabel.topAnchor*/, right: rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: 0, bottomConstant: 0/*ScreenSize.height * 0.01*/, rightConstant: ScreenSize.width * 0.02, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        locationLabel.anchor(editProfileButton.bottomAnchor/*profileView.bottomAnchor*/, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.001, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        locationView.anchor(locationLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.005, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.955, heightConstant: ScreenSize.height * 0.15)
        
        setupLocationView()
        
        statusLabel.anchor(locationView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.03, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        statusSegCon.anchor(statusLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.005, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: ScreenSize.height * 0.05)
        
        hoursLabel.anchor(statusSegCon.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.03, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        editHoursButton.anchor(statusSegCon.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: ScreenSize.height * 0.03, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.02, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.height * 0.04)
        
        hoursView.anchor(hoursLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.005, leftConstant: ScreenSize.width * 0.02, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.955, heightConstant: ScreenSize.height * 0.3)
        
        setupHoursView()
    }
    
    
    private func setupLocationView() {
        
        locationView.addSubview(locationImgView)
        locationView.addSubview(locationNameLabel)
        locationView.addSubview(agentLocationLabel)
        
        locationImgView.anchor(locationView.topAnchor, left: locationView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.1, heightConstant: ScreenSize.width * 0.1)
        
        locationNameLabel.anchor(locationView.topAnchor, left: locationImgView.rightAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.02, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.4, heightConstant: ScreenSize.width * 0.05)
        
        agentLocationLabel.anchor(locationNameLabel.bottomAnchor, left: locationImgView.rightAnchor, bottom: locationView.bottomAnchor, right: locationView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: ScreenSize.height * 0.01, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: 0)
    }
    
    private func setupHoursView() {
    
        hoursView.addSubview(monLbl)
        hoursView.addSubview(monHoursLbl)
        hoursView.addSubview(tuesLbl)
        hoursView.addSubview(tuesHoursLbl)
        hoursView.addSubview(wedLbl)
        hoursView.addSubview(wedHoursLbl)
        hoursView.addSubview(thursLbl)
        hoursView.addSubview(thursHoursLbl)
        hoursView.addSubview(friLbl)
        hoursView.addSubview(friHoursLbl)
        hoursView.addSubview(satLbl)
        hoursView.addSubview(satHoursLbl)
        hoursView.addSubview(sunLbl)
        hoursView.addSubview(sunHoursLbl)
        
        monLbl.anchor(hoursView.topAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        tuesLbl.anchor(monLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        wedLbl.anchor(tuesLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        thursLbl.anchor(wedLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        friLbl.anchor(thursLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        satLbl.anchor(friLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        sunLbl.anchor(satLbl.bottomAnchor, left: hoursView.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.25, heightConstant: ScreenSize.height * 0.03)
        
        monHoursLbl.anchor(hoursView.topAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        tuesHoursLbl.anchor(monHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        wedHoursLbl.anchor(tuesHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        thursHoursLbl.anchor(wedHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        friHoursLbl.anchor(thursHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        satHoursLbl.anchor(friHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        
        sunHoursLbl.anchor(satHoursLbl.bottomAnchor, left: monLbl.rightAnchor, bottom: nil, right: hoursView.rightAnchor, topConstant: ScreenSize.height * 0.01, leftConstant: ScreenSize.height * 0.01, bottomConstant: 0, rightConstant: ScreenSize.height * 0.01, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)

    }
    
    @objc func handleEditProfileTapped() {
        print("Edit profile button pressed...")
    }
    
    
    
}




