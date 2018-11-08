//
//  OrderSummaryScreenController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-08.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class OrderSummaryScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    
//    var menuTracker: Bool = false
    let cellId = "cellId"
    let fakeDataSource = ["blue", "red", "purple", "orange", "green", "yellow", "teal"]
    
    let orderSummaryView: UIView = {
        let view = UIView()
        return view
    }()
    
    let listOptionsView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var listOptionSegmentedController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Ready For pickup", "Delivered"])
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
        view.backgroundColor = .white
        setupViews()
        self.orderSummaryCollectionView.register(OrderSummaryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = orderSummaryCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OrderSummaryCell
        let color: String = self.fakeDataSource[indexPath.item]
        cell.label.text = color
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.width, height: ScreenSize.height * 0.1)
    }
    
    fileprivate func setupOrderSummaryView() {
        orderSummaryView.addSubview(orderSummaryCollectionView)
        orderSummaryCollectionView.anchor(orderSummaryView.topAnchor, left: orderSummaryView.leftAnchor, bottom: orderSummaryView.bottomAnchor, right: orderSummaryView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(handleMapButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(handleLeftBarButtonItemTapped))
        
        view.addSubview(listOptionSegmentedController)
        view.addSubview(orderSummaryView)
        
        slideInMenu = SlideInMenu(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
//        slideInMenu = SlideInMenu()
        slideInMenu.delegate = self
        slideInMenu.layer.zPosition = 100
        slideInMenu.isUserInteractionEnabled = true
        self.navigationController?.view.addSubview(slideInMenu)
//        self.view.addSubview(slideInMenu)
        
//        slideInMenu.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        blackScreen = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden = true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition = 99
        blackScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlackScreenTap)))
        
        
        listOptionSegmentedController.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.07)

        orderSummaryView.anchor(listOptionSegmentedController.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupOrderSummaryView()
    }
    
    @objc func handleSegmentValueChanged() {
        switch listOptionSegmentedController.selectedSegmentIndex {
            case 0: print("Ready for pick up")
            case 1: print("Delivered")
            default: print("none chosen")
        }
    }
    
    @objc func handleMapButtonTapped() {
        let gmsMapController = GMSMapController()
        let navGMSMap = UINavigationController(rootViewController: gmsMapController)
        present(navGMSMap, animated: true) {
            //fetch and load data to be displayed on the map
        }
    }
    
    @objc func handleLeftBarButtonItemTapped() {
//        if menuTracker == true {
//            hideMenu()
//            menuTracker = false
//        } else if menuTracker == false {
//            animateSlideInMenu()
//            menuTracker = true
//        }
        animateSlideInMenu()
    }
    
    @objc func handleBlackScreenTap() {
        hideMenu()
    }
    
    @objc func handleDismissButtonTapped() {
        hideMenu()
    }
    
    @objc func handleQRButtonPressed() {
        let qrCodeReader = QRCodeScannerController()
        let navQRCodeReader = UINavigationController(rootViewController: qrCodeReader)
        present(navQRCodeReader, animated: true) {
            //completion here
        }
    }
    
    @objc func handleLogoutButtonPressed() {
        let loginController = LoginController()
        present(loginController, animated: true) {
            //logout user from the database
        }
    }
    
    @objc func handleEditProfileTapped() {
        print("Pressed!")
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
}

extension ClientScreenController: SideBarViewDelegate {
    func sidebarDidSelect(row: Row) {
        blackScreen.isHidden = true
        blackScreen.frame = self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.slideInMenu.frame = CGRect(x: 0, y: 0, width: 0, height: self.slideInMenu.frame.height)
        }
        switch row {
        case .editProfile:
            print("Go to edit profile controller")
        case .orderSummary:
            print("Go to order summary webpage")
            let
        case .xboMarketShop:
            print("Go to XBO Market Shop webpage")
        case .earningsSummary:
            print("Go to Earning Summary webpage")
        case .scanTool:
            print("Go to QRScanningController")
            let qrCodeScannerController = QRCodeScannerController()
            let navQRController = UINavigationController(rootViewController: qrCodeScannerController)
            present(navQRController, animated: true) {
                //completion here. maybe pass data
            }
        case .logout:
            print("Go to Login Controller")
            //log out client here
            let loginController = LoginController()
            present(loginController, animated: true) {
                //try the log out here
            }
        case .none:
            break
//        default:
//            break
        }
    }
}
