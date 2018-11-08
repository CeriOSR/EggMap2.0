//
//  LoginController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-06.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import CoreData
//import realmSwift

struct KeychainConfiguration {
    static let serviceName = "EggMap"
    static let accessGroup: String? = nil
}

class LoginController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext?
    var localizedStringGetter = LocalizedStringGetter()
    var loginCredentials = LoginCredentials()
    var passwordItems : [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    struct GlobalLoginIDs {
        static var uid = String()
        static var uuid = String()
        static var userType = String()
        static var locationId = String()
    }
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Cartoon Egg")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()

    let userIdTextField : UITextField = {
        let tf = UITextField()
//        tf.placeholder = "username"
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        tf.layer.cornerRadius = 6
        tf.layer.masksToBounds = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 4.0, height: 2.0))
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
//        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        tf.layer.cornerRadius = 6
        tf.layer.masksToBounds = true
        //padding to the left by 4
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 4.0, height: 2.0))
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(r: 60, g: 172, b: 252, a: 1).cgColor
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    let remLabel: UILabel = {
        let label = UILabel()
//        label.text = "Remember me:"
        return label
    }()
    
    private func localizeController() {
        let username = localizedStringGetter.fetchLocalizedAttributedString(localizedString: "username", comment: "username placeholder in login controller")
        let password = localizedStringGetter.fetchLocalizedAttributedString(localizedString: "password", comment: "password placeholder in login controller")
        let login = localizedStringGetter.fetchLocalizedAttributedString(localizedString: "Login", comment: "Login button title in login controller")
        let rememberMe = localizedStringGetter.fetchLocalizedAttributedString(localizedString: "Remember me:", comment: "Remember me label in login controller")
        userIdTextField.placeholder = username.string
        passwordTextField.placeholder = password.string
        loginButton.setTitle(login.string, for: .normal)
        remLabel.text = rememberMe.string
        
    }
    
    private func localizaFromPlist() {
        let localizer = LocalizedPListStringGetter()
        userIdTextField.placeholder = localizer.parseLocalizable().username?.value
        passwordTextField.placeholder = localizer.parseLocalizable().password?.value
        remLabel.text = localizer.parseLocalizable().rememberMe?.value
        loginButton.setTitle(localizer.parseLocalizable().login?.value, for: .normal)
    }
    
    let remSwitch : UISwitch = {
        let rSwitch = UISwitch()
        rSwitch.isOn = false
        return rSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        localizaFromPlist()
//        localizeController()
        setupHasLoginKey()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func handleLoginTapped() {
        login()
    }
    
    private func setupHasLoginKey() {
        
            //change the userIdTextField to what is saved in the UserDefaults and the password to what is saved in the keychain
            if let storedUserName = UserDefaults.standard.value(forKey: "username") as? String {
                do {
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: storedUserName, accessGroup: KeychainConfiguration.accessGroup)
                    passwordTextField.text = try passwordItem.readPassword()
                } catch {
                    passwordTextField.text = ""
                }
                userIdTextField.text = storedUserName
        }
    }
    
    private func presentClientScreen() {
        let orderSummController = OrderSummaryScreenController()
        let navOrderSummController = UINavigationController(rootViewController: orderSummController)
        present(navOrderSummController, animated: true) {
            
        }
    }
    
    fileprivate func login() {
        
        guard let newAccountName = userIdTextField.text, let newPassword = passwordTextField.text, !newAccountName.isEmpty, !newPassword.isEmpty else {
            self.showLoginFailedAlert(message: "One or both fields are empty. Please fill them to log in.")
            return
        }
        userIdTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        fetchUidAndAccessToken(username: newAccountName, password: newPassword)
    }
    
    private func fetchUidAndAccessToken(username: String, password: String) {
    
        let urlString = "http://shoptraining.xbo-m.com" + "/DataSource/Mobile/?Action=Login&username=" + username + "&pwd=" + password
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    //login failed here
                    print("failed to get data from url", err)
                }
                guard let data = data else {return}
                do {
                    //doing this old school because database is not decodable
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    let dictionary = json["RequestResult"] as! [String: Any]
                    let loginData: Dictionary = dictionary["DATA"] as! [String: Any]
                    guard let uid = loginData["uid"] as? String else {
                        self.showLoginFailedAlert(message: "Unable to fetch a User Id.")
                        return
                    }
                    guard let uuid = loginData["uuid"] as? String else {
                        self.showLoginFailedAlert(message: "Unable to fetch an AccessToken.")
                        return
                    }
                    
                    guard let userType = loginData["UserType"] as? String else {
                        self.showLoginFailedAlert(message: "Unable to fetch the User type.")
                        return
                    }
                    UserDefaults.standard.set(uid, forKey: "uid")
                    UserDefaults.standard.set(uuid, forKey: "uuid")
                    UserDefaults.standard.set(userType, forKey: "userType")
                    GlobalLoginIDs.uid = uid
                    GlobalLoginIDs.uuid = uuid
                    GlobalLoginIDs.userType = userType
                    self.fetchChosenLocationById()
                    
                    self.saveUserToUserDefaultsAndKeychain(username: username, password: password)
                    
                }catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
        }.resume()
        
    }
    
    private func fetchChosenLocationById() {
        if let locationId = UserDefaults.standard.value(forKey: "locationId") as? String {
            GlobalLoginIDs.locationId = locationId
        } else {
            let getLocation = GetLocationJSON()
            getLocation.getLocationJSON { (location) in
                guard let locationId = location[0].id else {return}
                let locationAndSchedule = GetLocationDetailsByIDJSON()
                locationAndSchedule.getLocationAndScheduleDetailsById(id: locationId) { (location) in
                    UserDefaults.standard.set(locationId, forKey: "locationId")
                    GlobalLoginIDs.locationId = locationId
                }
            }
        }
    }
    
    private func saveUserToUserDefaultsAndKeychain(username: String, password: String) {
            if GlobalLoginIDs.uid == "" && GlobalLoginIDs.uuid == "" {
                self.showLoginFailedAlert(message: "Unable to fetch login credentials from server.")
            } else {
                let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
                DispatchQueue.main.async {
                    if !hasLoginKey && self.userIdTextField.hasText {
                        UserDefaults.standard.set(self.userIdTextField.text, forKey: "username")
                    }
                    //created a new KeychainPasswordItem with serviceName, newAccountName and accessGroup
                    if self.remSwitch.isOn {
                        do {
                            //new account, create a new keychain item with account name.
                            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username, accessGroup: KeychainConfiguration.accessGroup)
                            //save the password for the new item
                            try passwordItem.savePassword(password)
                            // set the hasLoginKey in UserDefaults to true to indicate password has been saved to the keychain.
                            UserDefaults.standard.set(true, forKey: "hasLoginKey")
                        } catch {
                            fatalError("Error updating keychain: \(error)")
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.presentClientScreen()
                }
            }
    }
    
    fileprivate func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username, accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        } catch {
            fatalError("Error reading password from keychain: \(error)")
        }
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(logoImageView)
        view.addSubview(userIdTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(remLabel)
        view.addSubview(remSwitch)
        
        logoImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.3, heightConstant: ScreenSize.width * 0.3)
        
        logoImageView.anchorCenterXToSuperview()
        
        userIdTextField.anchor(logoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.05)
        
        userIdTextField.anchorCenterXToSuperview()
        
        passwordTextField.anchor(userIdTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: ScreenSize.height * 0.05)
        passwordTextField.anchorCenterXToSuperview()
        
        remLabel.anchorCenterXToSuperview(constant: ScreenSize.width * 0.1)
        remLabel.anchor(passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.35, heightConstant: ScreenSize.height * 0.05)
        
    
        
        remSwitch.anchor(passwordTextField.bottomAnchor, left: nil, bottom: nil, right: remLabel.leftAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 2, widthConstant: ScreenSize.width * 0.15, heightConstant: ScreenSize.height * 0.05)
        
        loginButton.anchor(remSwitch.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: ScreenSize.height * 0.15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.30, heightConstant: ScreenSize.height * 0.05)
        loginButton.anchorCenterXToSuperview()
    }
    
    private func showLoginFailedAlert(message: String) {
        let alertView = UIAlertController(title: "Login Problem", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
}

