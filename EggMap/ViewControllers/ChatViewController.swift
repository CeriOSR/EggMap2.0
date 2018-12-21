//
//  ChatViewController.swift
//  EggMap
//
//  Created by Rey Cerio on 14/12/2018.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatViewController: UICollectionViewController {
    
    let localizer = LocalizedPListStringGetter()
    var slideInMenu: SlideInMenu!
    var blackScreen: UIView!
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = localizer.parseLocalizable().enterMessage?.value
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        return tf
    }()
    
    lazy var mapButton : UIButton = {
        let button = UIButton(type: .system)
        //rename to map
        button.setTitle(localizer.parseLocalizable().send?.value, for: .normal)
        button.setTitle("Map", for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(localizer.parseLocalizable().send?.value, for: .normal)
        return button
    }()
    
    lazy var micButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(localizer.parseLocalizable().mic?.value, for: .normal)
        return button
    }()
    
    let messages = ["sup", "Hey there, are you ready to party all the way to hollywood hills? Its gonna be lit AF, fam! We gonna Fuck the place up!", "Hey! It’s Melissa…I am just wondering if Stefan has arrived?", "What you up to?", "Hi Rey, Louisa said you dropped by SD today. The show in Vegas is called ‘KA’. It plays at the MGM GRAND. Incredible must see. Cheers!", "sup", "Hey there, are you ready to party all the way to hollywood hills? Its gonna be lit AF, fam! We gonna Fuck the place up!", "Hey! It’s Melissa…I am just wondering if Stefan has arrived?", "What you up to?", "Hi Rey, Louisa said you dropped by SD today. The show in Vegas is called ‘KA’. It plays at the MGM GRAND. Incredible must see. Cheers!"]
    let dates = ["99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM", "99-99-99, 99:99 AM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gavin Benson"
        self.view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.keyboardDismissMode = .interactive
        setupBackgroundView()
        setupSlideInMenu()
        self.collectionView!.register(ChatControllerFromCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "QR", style: .plain, target: self, action: #selector(handleRightBarButtonTapped))
        
    }
    
    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.13)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        setupContainerView(containerView: containerView)
        return containerView
        
    }()
    
    //initiating a view that sticks to the top of the keyboard
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    //make container view appear at bottom
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillAppear() {
        //Do something here
        inputContainerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.12)
    }
    
    @objc func keyboardWillDisappear() {
        //Do something here
        inputContainerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.12)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupContainerView(containerView: UIView) {
        containerView.addSubview(lineView)
        containerView.addSubview(self.messageTextField)
        containerView.addSubview(self.micButton)
        containerView.addSubview(self.sendButton)
        containerView.addSubview(self.mapButton)
        
        lineView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        self.messageTextField.anchor(lineView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.65, heightConstant: containerView.frame.height * 0.5)
        self.micButton.anchor(lineView.bottomAnchor, left: messageTextField.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.15, heightConstant: containerView.frame.height * 0.5)
        self.sendButton.anchor(lineView.bottomAnchor, left: self.micButton.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: containerView.frame.height * 0.5)
        self.mapButton.anchor(messageTextField.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.09)

    }
    
    @objc func handleRightBarButtonTapped() {
        //CREATE AN ALERT HERE THAT SHOWS PRODUCT DETAILS, QRCODE ETC
//        let alert = UIAlertController(title: "Prodct Code here", message: "Product details here and QRCode below", preferredStyle: .alert)
//        let okConfirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
//            alert.dismiss(animated: true, completion: {
//                //handle completion here if any
//            })
//        }
//        let qrImageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 150, height: 150))
//        qrImageView.image = #imageLiteral(resourceName: "EggMapDude").withRenderingMode(.alwaysOriginal)
//
//        alert.view.addSubview(qrImageView)
//        alert.addAction(okConfirmAction)
//        self.present(alert, animated: true) {
//            //handle completion here
//        }
        
        let showAlert = UIAlertController(title: "Demo Alert", message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
        imageView.image = #imageLiteral(resourceName: "EggMapDude").withRenderingMode(.alwaysOriginal)
        showAlert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // your actions here...
        }))
        self.present(showAlert, animated: true, completion: nil)
        
    }
    
    @objc func mapButtonTapped() {
        let pickLocationController = PickLocationController()
        navigationController?.pushViewController(pickLocationController, animated: true)
    }
    
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatControllerFromCell
        
        cell.messageLbl.text = messages[indexPath.item]
        cell.dateLbl.text = dates[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = ScreenSize.height * 0.2
        let text = messages[indexPath.item]
        let date = dates[indexPath.item]
        let heightText = estimatedFrameForText(text: text).height
        let heightDate = estimatedFrameForText(text: date).height
        height = heightText + heightDate + 20
        return CGSize(width: ScreenSize.width, height: height)
    }
    
    //making the bubble frame be the same size as its content
    private func estimatedFrameForText(text: String) -> CGRect {
        //height has to arbitrarily large
        let size = CGSize(width: ScreenSize.width * 0.8, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
}

//This has to do with the slide in menu only
extension ChatViewController: SideBarViewDelegate {
    
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
            let orderSummaryController = OrderSummaryScreenController()
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
            //            let navQRController = UINavigationController(rootViewController: qrCodeScannerController)
            //            present(navQRController, animated: true) {
            //                //completion here. maybe pass data
            //            }
            navigationController?.pushViewController(qrCodeScannerController, animated: true)
            
        case .logout:
            //log out client here
            let logoutModel = LogoutModel()
            logoutModel.fetchJsonLogout()
            let loginController = LoginController()
            present(loginController, animated: true) {
                //try the log out here
            }
        case .none:
            break
        }
    }
}
