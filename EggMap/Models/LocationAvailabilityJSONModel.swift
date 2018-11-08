//
//  LocationAvailabilityJSONModel.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-26.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct LocationClose {
    var oldOperatingStatus: String?
    var newOperatingStatus: String?
}

struct LocationOpen {
    var oldOperatingStatus: String?
    var newOperatingStatus: String?
}

struct RequestResult: Decodable {
    private enum CodingKeys: String, CodingKey {
        case action = "Action", params = "Params", data = "DATA"
    }
    var action : String?
    var params : Parameters?
    var data : UserData?
}

struct Parameters: Decodable {
    private enum CodingKeys: String, CodingKey{
        case actionGet = "Action_get", uid = "uid_get", id = "Id_get"
    }
    var actionGet: String?
    var uid: String?
    var id: String?
}

struct UserData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case oldOperatingStatus = "OldOperatingStatus", newOperatingStatus = "NewOperatingStatus"
    }
    var oldOperatingStatus: String?
    var newOperatingStatus: String?
}



class LocationAvailabilityJSONDataModel {
    
    let uid = LoginController.GlobalLoginIDs.uid
    let uuid = LoginController.GlobalLoginIDs.uuid
    
    func getLocationCloseJSONData(id: String, completion: @escaping (LocationClose) -> ()) {
        
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=LocationClose&uid=" + uid + "&uuid=" + uuid + "&Id=" + id
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("Handle this LocationClose URLSession error: ", err)
            }
            guard let data = data else {return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                guard let requestResult = json["RequestResult"] as? [String: Any] else {return}
                guard let data = requestResult["DATA"] as? [String: Any] else {return}
                var locationClose = LocationClose()
                locationClose.newOperatingStatus = data["NewOperatingStatus"] as? String
                locationClose.oldOperatingStatus = data["OldOperatingStatus"] as? String
                completion(locationClose)
                
            }catch let error {
                print("Handle this LocationClose JSON error: ", error)
            }
        }.resume()
    }
    
    func getLocationOpenJSONData(id: String, completion: @escaping (LocationOpen) -> ()) {
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=LocationOpen&uid=" + uid + "&uuid=" + uuid + "&Id=" + id
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("Handle this locationOpen URLSession error: ", err)
            }
            guard let data = data else {return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                guard let requestResult = json["RequestResult"] as? [String: Any] else {return}
                guard let data = requestResult["DATA"] as? [String: Any] else {return}
                var locationOpen = LocationOpen()
                locationOpen.newOperatingStatus = data["NewOperatingStatus"] as? String
                locationOpen.oldOperatingStatus = data["OldOperatingStatus"] as? String
                completion(locationOpen)
                
            }catch let error {
                print("Handle this locationOpen JSON error: ", error)
            }
        }.resume()
    }
    
    func getLocationOpenJSONDataDecoder(id: String, completion: @escaping (LocationOpen) -> ()) {
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=LocationOpen&uid=" + uid + "&uuid=" + uuid + "&Id=" + id
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("Handle this locationOpen URLSession error: ", err)
            }
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let locationOpen = try decoder.decode(RequestResult.self, from: data)
                print(locationOpen)
            }catch let error {
                print("Handle this locationOpen JSON error: ", error)
            }
        }.resume()
    }
    
    
    
}
