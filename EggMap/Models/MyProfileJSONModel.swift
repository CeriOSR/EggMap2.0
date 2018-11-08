//
//  MyProfileJSONModel.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-24.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

//struct RequestResult: Decodable {

//    private enum CodingKeys : String, CodingKey {
//        case action = "Action", params = "Params", data = "DATA"
//    }
//
//    var action: String?
//    var params: Parameter?
//    var data: UserData?
//}
//
//struct Parameter: Decodable {
//    private enum CodingKeys : String, CodingKey {
//        case action = "Action_get", uid = "uid_get"
//    }
//
//    var action: String?
//    var uid: String?
//}
//
//struct UserData: Decodable {
//
//    private enum CodingKeys : String, CodingKey {
//        case id = "Id", userCode = "UserCode", homePhone = "HomePhone"
//        case mobile = "Mobile", workPhone = "WorkPhone", email = "Email"
//        case altEmail = "AltEmail", unitNo = "UnitNo", streetNo = "StreetNo"
//        case streetName = "StreetName", city = "City", stateProvince = "StateProvince"
//        case country = "Country", zipPostalCode = "ZipPostalCode"
//    }
//
//    var id: String?, userCode: String?, homePhone: String?, mobile: String?
//    var workPhone: String?, email: String?, altEmail: String?, unitNo: String?
//    var streetNo: String?, streetName: String?, city, stateProvince: String?
//    var country: String?, zipPostalCode: String?
//}



struct MyProfile {
    var Id: String?
    var UserCode: String?
    var HomePhone: String?
    var Mobile: String?
    var WorkPhone: String?
    var Email: String?
    var AltEmail: String?
    var UnitNo: String?
    var StreetNo: String?
    var StreetName: String?
    var City: String?
    var StateProvince: String?
    var Country: String?
    var ZipPostalCode: String?
}

class MyProfileJSON {
    
    let uid = LoginController.GlobalLoginIDs.uid
    let uuid = LoginController.GlobalLoginIDs.uuid
    
    func getMyProfileJSONData(completion: @escaping (MyProfile) -> ()) {
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=MyProfile&uid=" + uid + "&uuid=" + uuid
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("Handle MyProfileJSON error: ", err)
            }
            guard let data = data else {return}
            do {
                // swift 4.2 but we cant use it right now
//                let profile = try JSONDecoder().decode(RequestResult.self, from: data)
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                guard let requestResult = json["RequestResult"] as? [String: Any] else {return}
                guard let data = requestResult["DATA"] as? [String: Any] else {return}
                var profile = MyProfile()
                profile.Id = data["Id"] as? String
                profile.UserCode = data["UserCode"] as? String
                profile.HomePhone = data["HomePhone"] as? String
                profile.Mobile = data["Mobile"] as? String
                profile.WorkPhone = data["WorkPhone"] as? String
                profile.Email = data["Email"] as? String
                profile.AltEmail = data["AltEmail"] as? String
                profile.UnitNo = data["UnitNo"] as? String
                profile.StreetNo = data["StreetNo"] as? String
                profile.StreetName = data["StreetName"] as? String
                profile.City = data["City"] as? String
                profile.StateProvince = data["StateProvince"] as? String
                profile.Country = data["Country"] as? String
                profile.ZipPostalCode = data["ZipPostalCode"] as? String
                
                completion(profile)
            } catch let err {
                print("Handle Decoder Error: ", err)
            }
            
        }.resume()
    }
    
    
}
