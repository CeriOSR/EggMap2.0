//
//  AgentSideOrderSummaryScreenController.swift
//  EggMap
//
//  Created by Mei on 2018-12-26.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AgentSideOrderSummaryScreenController: UIViewController {
    
    let localizer = LocalizedPListStringGetter()
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    var userType = LoginController.GlobalLoginIDs.userType
    
    let cellId = "cellId"
    var readyOrders = [UndeliveredOrder]() {
        didSet{
            DispatchQueue.main.async {
                if self.readyOrders.count == 1 {
                    //guard let id = readyOrders[indexPath.item].id else {return}
                    //test id, delete later use line above
                    let id = "73DBE3A6-6783-4A98-A681-B9020E864080"
                    
                    let gmsMapController = ClientSideOrderAvailabilityMapController()
                    let locationDetailsById = GetLocationDetailsByIDJSON()
                    locationDetailsById.getLocationAndScheduleDetailsById(id: id) { (locationDetails) in
                        print(locationDetails)
                        let addressString = locationDetailsById.formAddressString(location: locationDetails)
                        gmsMapController.addressString = addressString
                    }
                    self.navigationController?.pushViewController(gmsMapController, animated: true)
                } else {
                    print("Undelivered orders: \(self.readyOrders)")
                    self.orderSummaryCollectionView.reloadData()
                }
            }
        }
    }
    var finishedOrders = [DeliveredOrder]() {
        didSet{
            DispatchQueue.main.async {
                self.orderSummaryCollectionView.reloadData()
                
            }
        }
    }
    
    let orderSummaryView: UIView = {
        let view = UIView()
        return view
    }()
    
    let listOptionsView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var listOptionSegmentedController: UISegmentedControl = {
        let ready = localizer.parseLocalizable().readyForPickup?.value
        let delivered = localizer.parseLocalizable().ordersTaken?.value
        let segmentController = UISegmentedControl(items: [ready ?? "Ready For Pickup", delivered ?? "Orders Taken"])
        segmentController.selectedSegmentIndex = 0
        segmentController.addTarget(self, action: #selector(handleSegmentValueChanged), for: .valueChanged)
        return segmentController
    }()
    
    lazy var orderSummaryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: self.orderSummaryView.frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserHasCredentials()
        view.backgroundColor = .white
        self.orderSummaryCollectionView.register(AgentSideOrderSummaryCell.self, forCellWithReuseIdentifier: cellId)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userType == "1" {
            fetchUndelivered()
        } else {
            //method for client side here
        }
        
    }
    
    private func checkIfUserHasCredentials() {
        if LoginController.GlobalLoginIDs.uid.isEmpty || LoginController.GlobalLoginIDs.uid == "" && LoginController.GlobalLoginIDs.uuid.isEmpty || LoginController.GlobalLoginIDs.uuid == "" {
            let loginController = LoginController()
            present(loginController, animated: true) {
                //try the log out here
            }
        }
    }
    
    private func fetchUndelivered() {
        let undeliveredOrders = UndeliveredOrdersJSONData()
        undeliveredOrders.fetchMyUndeliveredOrdersJSONData(completion: { (undeliveredOrders) in
            self.readyOrders = undeliveredOrders
        })
    }
    
    fileprivate func setupOrderSummaryView() {
        orderSummaryView.addSubview(orderSummaryCollectionView)
        orderSummaryCollectionView.anchor(orderSummaryView.topAnchor, left: orderSummaryView.leftAnchor, bottom: orderSummaryView.bottomAnchor, right: orderSummaryView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func setupViews() {
        let map = localizer.parseLocalizable().map?.value
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: map ?? "Map", style: .plain, target: self, action: #selector(handleMapButtonTapped))
        view.addSubview(listOptionSegmentedController)
        view.addSubview(orderSummaryView)
        setupSlideInMenu()
        listOptionSegmentedController.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.07)
        
        orderSummaryView.anchor(listOptionSegmentedController.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: ScreenSize.height * 0.001, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupOrderSummaryView()
    }
    
    @objc func handleSegmentValueChanged() {
        
        switch listOptionSegmentedController.selectedSegmentIndex {
        case 0:
            let readyOrders = UndeliveredOrdersJSONData()
            readyOrders.fetchMyUndeliveredOrdersJSONData(completion: { (readyOrders) in
                self.readyOrders = readyOrders
                
            })
            
        case 1:
            let deliveredOrders = DeliveredOrdersJSONData()
            deliveredOrders.fetchMyDeliveredOrdersJSONData(completion: { (deliveredOrders) in
                self.finishedOrders = deliveredOrders
                
            })
            
        default: print("none chosen")
        }
    }
    
    //    private func fetchClientLocation(id: String) {
    //        let locationDetailsById = GetLocationDetailsByIDJSON()
    //        locationDetailsById.getLocationAndScheduleDetailsById(id: id) { (locationDetails) in
    //            <#code#>
    //        }
    //    }
    
    //change this to didselect to show where the availability is...
    @objc func handleMapButtonTapped() {
        let waitingForAgentsController = WaitingForAgentsController()
        navigationController?.pushViewController(waitingForAgentsController, animated: true)
    }
}

extension AgentSideOrderSummaryScreenController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listOptionSegmentedController.selectedSegmentIndex == 0 {
            return readyOrders.count
        } else {
            return finishedOrders.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = orderSummaryCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AgentSideOrderSummaryCell
        
        //change these to ready orders and taken orders
        let readyOrder: UndeliveredOrder?
        let finishedOrder: DeliveredOrder?
        
        if self.listOptionSegmentedController.selectedSegmentIndex == 0 {
//            readyOrder = readyOrders[indexPath.item]
//            cell.orderLabel.text = readyOrder?.contractNo
//            cell.dateLabel.text = readyOrder?.memo
//            cell.statusLabel.text = readyOrder?.policyStatusName
//            cell.productLabel.text = readyOrder?.id
//            cell.rateBtn.isHidden = true
        } else {
//            finishedOrder = finishedOrders[indexPath.item]
//            cell.orderLabel.text = finishedOrder?.contractNo
//            cell.dateLabel.text = finishedOrder?.memo
//            cell.statusLabel.text = finishedOrder?.policyStatusName
//            cell.productLabel.text = finishedOrder?.id
//            cell.rateBtn.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width, height: ScreenSize.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if listOptionSegmentedController.selectedSegmentIndex == 1 {
//            let layout = UICollectionViewFlowLayout()
//            let chatController = ChatViewController(collectionViewLayout: layout)
//            navigationController?.pushViewController(chatController, animated: true)
        } else {
            
            //        guard let id = readyOrders[indexPath.item].id else {return}
            //test ID delete later use line above
            let id = "73DBE3A6-6783-4A98-A681-B9020E864080"
            
            let alert = UIAlertController(title: "Take Order", message: "Do you want to take this order?", preferredStyle: .alert)
            let take = UIAlertAction(title: "Ok", style: .default) { (action) in
                //send to database and move to Orders Taken
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
                alert.dismiss(animated: true, completion: {
                    //handle completion here if needed.
                })
            }
            alert.addAction(take)
            alert.addAction(cancel)
            self.present(alert, animated: true) {
                //handle completion of alert presentation here if needed.
            }
        }
    }
}

//This has to do with the slide in menu only
extension AgentSideOrderSummaryScreenController: SideBarViewDelegate {
    
    @objc func handleBlackScreenTap() {
        hideMenu()
    }
    
    @objc func handleMenuTapped() {
        animateSlideInMenu()
    }
    
    fileprivate func setupSlideInMenu() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: localizer.parseLocalizable().menu?.value, style: .plain, target: self, action: #selector(handleMenuTapped))
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
        case .compensation:
            let webView = WebViewController()
            navigationController?.pushViewController(webView, animated: true)
        case .scanTool:
            let qrCodeScannerController = QRCodeScannerController()
            navigationController?.pushViewController(qrCodeScannerController, animated: true)
            
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
        }
    }
}
