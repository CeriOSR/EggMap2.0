//
//  LogoutModel.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-19.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

class LogoutModel {
    
    func fetchJsonLogout() {
        let uid = LoginController.GlobalLoginIDs.uid
        let uuid = LoginController.GlobalLoginIDs.uuid
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=Logout&uid=" + uid + "&uuid=" + uuid
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("failed to access url:", err)
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                let dictionary = json["RequestResult"] as! [String: Any]
                let logoutData = dictionary["DATA"] as! [String: Any]
                let status: Bool = logoutData["Status"] as! Bool
                
                LoginController.GlobalLoginIDs.uid = ""
                LoginController.GlobalLoginIDs.uuid = ""
                LoginController.GlobalLoginIDs.userType = ""
                LoginController.GlobalLoginIDs.locationId = ""
                
                UserDefaults.standard.removeObject(forKey: "uid")
                UserDefaults.standard.removeObject(forKey: "uuid")
                UserDefaults.standard.removeObject(forKey: "userType")
                UserDefaults.standard.removeObject(forKey: "locationId")

            } catch let error {
                print("Logout Json fetching error:", error)
            }
            

        }.resume()
    }
}
