//
//  ClientProfileController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-24.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ClientProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var profile: MyProfile? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    func didTapEditProfile() {
        let agentLocation = AgentLocationsController()
        self.navigationController?.pushViewController(agentLocation, animated: true)
    }
    
    
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(ClientProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .white
        self.title = "Client Profile"
        setupSlideInMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getProfileJSONData()
    }
    
    private func getProfileJSONData() {
        let myProfile = MyProfileJSON()
        myProfile.getMyProfileJSONData { (profile) in
            self.profile = profile
        }
    }
    
    private func formAddressString(profile: MyProfile) -> String {
        guard let streetNo = profile.StreetNo else {return ""}
        guard let streetName =  profile.StreetName else {return ""}
        guard let city = profile.City else {return ""}
        guard let stateProvince = profile.StateProvince else {return ""}
        guard let country = profile.Country else {return ""}
        guard let zipcode = profile.ZipPostalCode else {return ""}
        let addressString = streetNo + " " + streetName + " " +  city + ", " + stateProvince + ", " + country + ", " + zipcode
        return addressString
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ClientProfileCell
        cell.client.editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        guard let profile = self.profile else {return cell}
        cell.client.profileNameLabel.text = LoginController.GlobalLoginIDs.userType as String
        cell.client.clientEmailLabel.text = profile.Email
        cell.client.clientPhoneLabel.text = profile.Mobile
        cell.client.clientAddressLabel.text = formAddressString(profile: profile)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: ScreenSize.height * 1)
    }
    
    @objc func didTapEditProfileButton() {
        let agentLocation = AgentLocationsController()
        navigationController?.pushViewController(agentLocation, animated: true)
    }
    
}

//This has to do with the slide in menu only
extension ClientProfileController: SideBarViewDelegate {
    
    @objc func handleBlackScreenTap() {
        hideMenu()
    }
    
    @objc func handleMenuTapped() {
        animateSlideInMenu()
    }
    
    fileprivate func setupSlideInMenu() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(handleMenuTapped))
        slideInMenu = SlideInMenu(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        slideInMenu.delegate = self
        slideInMenu.layer.zPosition = 100
        slideInMenu.isUserInteractionEnabled = true
        self.navigationController?.view.addSubview(slideInMenu)
        
        blackScreen = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden = true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition = 99
        blackScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackScreenTap)))
    }
    
    fileprivate func animateSlideInMenu() {
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            //animate here
            self.blackScreen.isHidden = false
            self.slideInMenu.frame = CGRect(x: 0, y: 0, width: ScreenSize.width * 0.75, height: self.slideInMenu.frame.height)
        }) { (_) in
            //completion
            self.blackScreen.frame = CGRect(x: self.slideInMenu.frame.width, y: 0, width: self.view.frame.width - self.slideInMenu.frame.width, height: self.view.bounds.height + 100)
        }
    }
    
    fileprivate func hideMenu() {
        blackScreen.isHidden = true
        blackScreen.frame = self.view.bounds
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.slideInMenu.frame = CGRect(x: 0, y: 0, width: 0, height: self.slideInMenu.frame.height)
        }) { (_) in
            //completion
        }
    }
    
    func sidebarDidSelect(row: Row) {
        blackScreen.isHidden = true
        blackScreen.frame = self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.slideInMenu.frame = CGRect(x: 0, y: 0, width: 0, height: self.slideInMenu.frame.height)
        }
        switch row {
        case .editProfile:
            
            if LoginController.GlobalLoginIDs.userType == "1" {
                let layout = UICollectionViewFlowLayout()
                let clientProfileController = ClientProfileController(collectionViewLayout: layout)
                let navProfileController = UINavigationController(rootViewController: clientProfileController)
                present(navProfileController, animated: true) {
                    //completion here, maybe pass some data
                }
            } else {
                let layout = UICollectionViewFlowLayout()
                let agentProfileController = AgentProfileController(collectionViewLayout: layout)
                let navProfileController = UINavigationController(rootViewController: agentProfileController)
                present(navProfileController, animated: true) {
                    //completion here, maybe pass some data
                }
            }
        case .orderSummary:
            let orderSummaryController = ClientSideOrderSummaryScreenController()
            let navOrderSummController = UINavigationController(rootViewController: orderSummaryController)
            present(navOrderSummController, animated: true) {
                //completion here, maybe pass some data
            }
        case .xboMarketShop:
            let webView = WebViewController()
            navigationController?.pushViewController(webView, animated: true)
        case .earningsSummary:
            let webView = WebViewController()
            navigationController?.pushViewController(webView, animated: true)
        case .scanTool:
            let qrCodeScannerController = QRCodeScannerController()
            let navQRController = UINavigationController(rootViewController: qrCodeScannerController)
            present(navQRController, animated: true) {
                //completion here. maybe pass data
            }
//        case .clientProfile:
//            let layout = UICollectionViewFlowLayout()
//            let clientProfileController = ClientProfileController(collectionViewLayout: layout)
//            let navProfileController = UINavigationController(rootViewController: clientProfileController)
//            present(navProfileController, animated: true) {
//                //completion here, maybe pass some data
//            }
        case .logout:
            //log out client here
            let logoutModel = LogoutModel()
            logoutModel.fetchJsonLogout()
            UserDefaults.standard.removeObject(forKey: "uid")
            UserDefaults.standard.removeObject(forKey: "uuid")
            UserDefaults.standard.removeObject(forKey: "userType")
            let loginController = LoginController()
            present(loginController, animated: true) {
                LoginController.GlobalLoginIDs.locationId = ""
                LoginController.GlobalLoginIDs.uid = ""
                LoginController.GlobalLoginIDs.uuid = ""
                LoginController.GlobalLoginIDs.userType = ""
            }
        case .none:
            break
        case .compensation:
            let webView = WebViewController()
            navigationController?.pushViewController(webView, animated: true)
        }
    }
}


