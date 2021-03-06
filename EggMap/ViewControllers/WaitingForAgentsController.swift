//
//  WaitingForAgentsController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-09-27.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class WaitingForAgentsController: UIViewController {
    
    let localizer = LocalizedPListStringGetter()
    var slideInMenu = SlideInMenu()
    var blackScreen = UIView()
    var starRating = FiveStarRatingNonInteractiveImage(frame: CGRect(x: (CGFloat(UIScreen.main.bounds.width) - CGFloat((5 * nStarSize) + (4 * nSpacing))) / 2
        , y: ScreenSize.height * 0.15, width: CGFloat((5 * nStarSize) + (4 * nSpacing)), height: CGFloat(nStarSize) ))
    
    lazy var requestView : UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleRequestViewTapped))
        view.addGestureRecognizer(tap)
        view.isHidden = false
        return  view
    }()
    
    let myRatingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "My Rating: "
        lbl.textAlignment = .right
        lbl.font.withSize(12)
        return lbl
    }()
    
    let numberOfRatingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "(\(kStarSize))"
        lbl.font.withSize(12)
        return lbl
    }()
    
    let thumbImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "To obtain good ratings, please be mindful of others and avoid aborting orders during delivery and pickup process."
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var rotatingArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var messageBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Message Gavin Benson", for: .normal)
        btn.addTarget(self, action: #selector(handleMessageBtnTapped), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    let waitingLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Waiting for agents..."
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let requestTimeLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "99:99:99 PM, NOVEMBER 12, 2018"
        return lbl
    }()
    
    let requestLocationLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "30456 99999 Long Ass Street Name Rd, Richmond BC, V6Z 9N9"
        return lbl
    }()
    
    let requestInstructions: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Tap here to change requested time or location:"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        animateRotatingArrow(targetView: rotatingArrowImage, duration: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    private func animateRotatingArrow(targetView: UIImageView, duration: TimeInterval) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.rotatingArrowImage.transform = self.rotatingArrowImage.transform.rotated(by: CGFloat.pi/1) 
        }) { (completion) in
            self.animateRotatingArrow(targetView: self.rotatingArrowImage, duration: 1)
        }
    }
    
    private func setupViews() {
        title = "Waiting for Agents..."
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Abort", style: .plain, target: self, action: #selector(handleRightBarButtonTapped))
        
        //delete this after test
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleWaitingLblTapped))
        self.waitingLbl.addGestureRecognizer(tap)

        setupSlideInMenu()
        view.addSubview(starRating)
        view.addSubview(myRatingsLbl)
        view.addSubview(numberOfRatingsLbl)
        view.addSubview(thumbImage)
        view.addSubview(warningLabel)
        view.addSubview(rotatingArrowImage)
        view.addSubview(waitingLbl)
        view.addSubview(messageBtn)
        view.addSubview(requestView)
        requestView.addSubview(requestInstructions)
        requestView.addSubview(requestTimeLbl)
        requestView.addSubview(requestLocationLbl)
        
        myRatingsLbl.anchor(starRating.topAnchor, left: nil, bottom: nil, right: starRating.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: ScreenSize.width * 0.01, widthConstant: ScreenSize.width * 0.28, heightConstant: ScreenSize.height * 0.025)
        
        numberOfRatingsLbl.anchor(starRating.topAnchor, left: starRating.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: ScreenSize.width * 0.01, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.1, heightConstant: ScreenSize.height * 0.025)
        
        thumbImage.anchor(starRating.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.05, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.height * 0.1, heightConstant: ScreenSize.height * 0.1)
        thumbImage.anchorCenterXToSuperview()
        
        warningLabel.anchor(thumbImage.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.05, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.1)
        warningLabel.anchorCenterXToSuperview()
        
        rotatingArrowImage.anchor(warningLabel.bottomAnchor, left: warningLabel.leftAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.05, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.height * 0.05, heightConstant: ScreenSize.height * 0.05)
        
        waitingLbl.anchor(warningLabel.bottomAnchor, left: rotatingArrowImage.rightAnchor, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.05, leftConstant: ScreenSize.width * 0.05, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.7, heightConstant: ScreenSize.height * 0.05)
        
        messageBtn.anchor(waitingLbl.bottomAnchor, left: waitingLbl.leftAnchor, bottom: nil, right: waitingLbl.rightAnchor, topConstant: 20, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: ScreenSize.height * 0.05)
        
        requestView.anchor(waitingLbl.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 20, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: ScreenSize.height * 0.2)
        
        requestInstructions.anchor(requestView.topAnchor, left: requestView.leftAnchor, bottom: nil, right: requestView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: requestView.frame.height * 0.3)
        
        requestTimeLbl.anchor(requestInstructions.bottomAnchor, left: requestView.leftAnchor, bottom: nil, right: requestView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: requestView.frame.height * 0.15)
        
        requestLocationLbl.anchor(requestTimeLbl.bottomAnchor, left: requestView.leftAnchor, bottom: requestView.bottomAnchor, right: requestView.rightAnchor, topConstant: 6, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    //redundant, fix this
    @objc func handleRightBarButtonTapped() {
        let alert = UIAlertController(title: "Abort order?", message: "Unless absolutely necessary, we do not encourage aborting an order that is currently processed.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter reason for aborting order."
        }
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let orderSummaryController = ClientSideOrderSummaryScreenController()
            let navOrderSummary = UINavigationController(rootViewController: orderSummaryController)
            self.present(navOrderSummary, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true) {
            //completion handler here
        }
    }
    
    //remove after test, not an actual functionality
    @objc func handleWaitingLblTapped() {
        rotatingArrowImage.isHidden = true
        waitingLbl.text = "Gavin Benson accepted"
        waitingLbl.textAlignment = .center
        waitingLbl.leftAnchor.constraint(equalTo: warningLabel.leftAnchor, constant: 0).isActive = true
        requestView.isHidden = true
        messageBtn.isHidden = false
    }
    
    @objc func handleMessageBtnTapped() {
        print("Message button tapped")
    }
    
    //need to also get store/agent locations
    @objc func handleRequestViewTapped() {
        print("Segue back to map to change delivery options")
        let id = "73DBE3A6-6783-4A98-A681-B9020E864080"
        let gmsMapController = ClientSideOrderAvailabilityMapController()
        let locationDetailsById = GetLocationDetailsByIDJSON()
        locationDetailsById.getLocationAndScheduleDetailsById(id: id) { (locationDetails) in
            print(locationDetails)
            let addressString = locationDetailsById.formAddressString(location: locationDetails)
            gmsMapController.addressString = addressString
        }
        let navGmsMapController = UINavigationController(rootViewController: gmsMapController)
        self.present(navGmsMapController, animated: true) {
            //completion here
        }
    }
}

//This has to do with the slide in menu only
extension WaitingForAgentsController: SideBarViewDelegate {
    
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
        case .compensation:
            let webView = WebViewController()
            navigationController?.pushViewController(webView, animated: true)
        }
    }
}

