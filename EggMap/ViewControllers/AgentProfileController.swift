//
//  UserProfileController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-24.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AgentProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var selected = 1
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    var profile: MyProfile? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    //get location from selected location
    var currentLocation : LocationDataModel?
    var locationAndSchedule: LocationAndScheduleByIdDataModel? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(AgentProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = .white
        self.title = "Profile"
        setupSlideInMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getProfileJSONData()
        getLocationByIdJsonData()
    }
    
    private func getProfileJSONData() {
        let myProfile = MyProfileJSON()
        myProfile.getMyProfileJSONData { (profile) in
            self.profile = profile
//            DispatchQueue.main.async {
//                self.collectionView?.reloadData()
//            }
        }
    }
    
    private func getLocationByIdJsonData() {
        let getLocationDetailsByIDJSON = GetLocationDetailsByIDJSON()
        if let id = currentLocation?.id  {
            getLocationDetailsByIDJSON.getLocationAndScheduleDetailsById(id: id) { (locationById) in
                self.locationAndSchedule = locationById
            }
        } else {
            let id = LoginController.GlobalLoginIDs.locationId
            getLocationDetailsByIDJSON.getLocationAndScheduleDetailsById(id: id) { (locationById) in
                self.locationAndSchedule = locationById
            }
        }
       
    }
    
    private func formAddressString(location: LocationAndScheduleByIdDataModel) -> String {
        guard let streetNo = location.streetNo else {return ""}
        guard let streetName =  location.streetName else {return ""}
        guard let city = location.city else {return ""}
        guard let stateProvince = location.stateProvince else {return ""}
        guard let country = location.country else {return ""}
        guard let zipcode = location.zipPostalCode else {return ""}
        let addressString = streetNo + " " + streetName + " " +  city + ", " + stateProvince + ", " + country + ", " + zipcode
        return addressString
    }
    
    @objc func didChangeSelectedIndex(sender: UISegmentedControl, cell: AgentProfileCell) {
            let cell = AgentProfileCell()
            self.changeSegConValue(cell: cell)
    }
    
    @objc func editHoursDidTap(sender: UIButton) {
        let agentLocation = AgentLocationsController()
        self.navigationController?.pushViewController(agentLocation, animated: true)
    }
    
    @objc func editProfileDidTap(sender: UIButton) {
        let locationAvailability = LocationAvailabilityJSONDataModel()
        guard let id = currentLocation?.id else {return}
        locationAvailability.getLocationOpenJSONDataDecoder(id: id, completion: { (locationOpen) in
            print(locationOpen)
        })
    }
    
    func changeSegConValue(cell: AgentProfileCell) {
        let locationAvailability = LocationAvailabilityJSONDataModel()
        guard let id = self.currentLocation?.id else {return}
        switch selected {
        case 0:
            locationAvailability.getLocationOpenJSONData(id: id) { (locationOpen) in
                print(locationOpen)
            }
            selected = 1
        case 1:
            locationAvailability.getLocationCloseJSONData(id: id) { (locationClose) in
                print(locationClose)
            }
            selected = 0
        default:
            return
        }
    }
    
    @objc func locationViewDidTap(sender: UIButton) {
        let agentLocation = AgentLocationsController()
        self.navigationController?.pushViewController(agentLocation, animated: true)
    }
    
}

extension AgentProfileController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AgentProfileCell
        
        cell.agent.editProfileButton.tag = 1
        cell.agent.editProfileButton.addTarget(self, action: #selector(editProfileDidTap(sender:)), for: .touchUpInside)
        
        cell.agent.editHoursButton.tag = 2
        cell.agent.editHoursButton.addTarget(self, action: #selector(editHoursDidTap), for: .touchUpInside)
        
        cell.agent.locationView.tag = 3
        cell.agent.locationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationViewDidTap)))
        
        cell.agent.statusSegCon.tag = 4
        cell.agent.statusSegCon.addTarget(self, action: #selector(didChangeSelectedIndex), for: .valueChanged)
        
        if let profile = self.profile {
            cell.agent.profileNameLabel.text = LoginController.GlobalLoginIDs.userType as String
            cell.agent.phoneLabel.text = profile.Mobile
            cell.agent.emailLabel.text = profile.Email
        }
        
//        guard let location = currentLocation else {return cell}
        guard let location = locationAndSchedule else {return cell}
        guard let availableDays = location.schedule else {return cell}
        cell.agent.locationNameLabel.text = locationAndSchedule?.name
        cell.agent.agentLocationLabel.text = formAddressString(location: location)
        
        for day in availableDays {
            switch day.day {
                
            case "1":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.sunHoursLbl.text = "\(open) - \(close)"
                
            case "2":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.monHoursLbl.text = "\(open) - \(close)"
                
            case "3":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.tuesHoursLbl.text = "\(open) - \(close)"
                
            case "4":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.wedHoursLbl.text = "\(open) - \(close)"
                
            case "5":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.thursHoursLbl.text = "\(open) - \(close)"
            case "6":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.friHoursLbl.text = "\(open) - \(close)"
                
            case "7":
                guard let open = day.hoursOpen, let close = day.hoursClose else {return cell}
                cell.agent.satHoursLbl.text = "\(open) - \(close)"
                
            default:
                return cell
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: ScreenSize.height * 1.1)
    }
}

//This has to do with the slide in menu only
extension AgentProfileController: SideBarViewDelegate {
    
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


