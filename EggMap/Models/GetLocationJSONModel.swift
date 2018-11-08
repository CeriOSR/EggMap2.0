//
//  GetLocationJSONModel.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-20.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct LocationDataModel {
    var id: String?
    var userRef: String?
    var userRefName: String?
    var name: String?
    var desc: String?
    var locationOwner: String?
    var locationOwnerName: String?
    var isHouseLocation: String?
    var closeOnPublicHolidays: String?
    var itemHolding: String?
    var totalItemHolding: String?
    var unitNo: String?
    var streetNo: String?
    var streetName: String?
    var city: String?
    var stateProvince: String?
    var country: String?
    var zipPostalCode: String?
    var lat: String?
    var long: String?
    var staticLocation: String?
    var status: String?
    var statusName: String?
    var operatingStatus: String?
    var operatingStatusName: String?
}

class GetLocationJSON {
    
    //CALLBACK!!!! LEARNED SOMETHING FUCKING NEW EVERYDAY!
    
    func getLocationJSON(completion: @escaping ([LocationDataModel]) -> ()) {
        let uid = LoginController.GlobalLoginIDs.uid
        let uuid = LoginController.GlobalLoginIDs.uuid
        var locationDataModel = LocationDataModel()
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=GetMyLocation&uid=" + uid + "&uuid=" + uuid
        guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { (data, _ , error) in
                if let err = error {
                    print("Error fetching data:", err)
                }
                guard let data = data else {return}
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    
                    let requestResult = json["RequestResult"] as! [String: Any]
                    let locData = requestResult["DATA"] as! [String: Any]
                    let locations = locData["ROWS"] as! [[String: Any]]
                    for locationDetails in locations {                        
                        locationDataModel.id = locationDetails["Id"] as? String
                        locationDataModel.userRef = locationDetails["UserRef"] as? String
                        locationDataModel.userRefName = locationDetails["UserRefName"] as? String
                        locationDataModel.name = locationDetails["Name"] as? String
                        locationDataModel.desc = locationDetails["Desc"] as? String
                        locationDataModel.locationOwner = locationDetails["LocationOwner"] as? String
                        locationDataModel.locationOwnerName = locationDetails["LocationOwnerName"] as? String
                        locationDataModel.isHouseLocation = locationDetails["IsHouseLocation"] as? String
                        locationDataModel.closeOnPublicHolidays = locationDetails["CloseOnPublicHolidays"] as? String
                        locationDataModel.itemHolding = locationDetails["ItemHolding"] as? String
                        locationDataModel.totalItemHolding = locationDetails["TotalItemHolding"] as? String
                        locationDataModel.unitNo = locationDetails["UnitNo"] as? String
                        locationDataModel.streetNo = locationDetails["StreetNo"] as? String
                        locationDataModel.streetName = locationDetails["StreetName"] as? String
                        locationDataModel.city = locationDetails["City"] as? String
                        locationDataModel.stateProvince = locationDetails["StateProvince"] as? String
                        locationDataModel.country = locationDetails["Country"] as? String
                        locationDataModel.zipPostalCode = locationDetails["ZipPostalCode"] as? String
                        locationDataModel.lat = locationDetails["lat"] as? String
                        locationDataModel.long = locationDetails["lng"] as? String
                        locationDataModel.staticLocation = locationDetails["StaticLocation"] as? String
                        locationDataModel.status = locationDetails["Status"] as? String
                        locationDataModel.statusName = locationDetails["StatusName"] as? String
                        locationDataModel.operatingStatus = locationDetails["OperatingStatus"] as? String
                        locationDataModel.operatingStatusName = locationDetails["OperatingStatusName"] as? String
                        
                        var locationsDataArray = [LocationDataModel]()
                        
                        locationsDataArray.append(locationDataModel)
                        completion(locationsDataArray)
                    }
                }catch let err {
                    print("Error Serializing Location Data:" , err)
                }
            }.resume()
    }
}
