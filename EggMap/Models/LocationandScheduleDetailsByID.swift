//
//  LocationandScheduleDetailsByID.swift
//  EggMap
//
//  Created by Mei on 2018-08-22.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct LocationAndScheduleByIdDataModel {
    //no id, no itemholdings, stops at lat lng
    var userRef: String?
    var userRefName: String?
    var name: String?
    var desc: String?
    var locationOwner: String?
    var locationOwnerName: String?
    var isHouseLocation: String?
    var closeOnPublicHolidays: String?
    var unitNo: String?
    var streetNo: String?
    var streetName: String?
    var city: String?
    var stateProvince: String?
    var country: String?
    var zipPostalCode: String?
    var lat: String?
    var long: String?
    var schedule: [OfficeHours]?
}

struct OfficeHours {
    var day: String?
    var hoursOpen: String?
    var hoursClose: String?
}


class GetLocationDetailsByIDJSON {
    
    func getLocationAndScheduleDetailsById(id: String, completion: @escaping (LocationAndScheduleByIdDataModel) -> ()) {
        var locationAndScheduleDetails = LocationAndScheduleByIdDataModel()
        var availableDays = [OfficeHours]()
        
        let uid = LoginController.GlobalLoginIDs.uid
        let uuid = LoginController.GlobalLoginIDs.uuid
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=GetLocationDetailById&uid=" + uid + "&uuid=" + uuid + "&Id=" + id
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error as? String{
                print("Handle this GetLocationDetailsByIDJSON URLSession error:", err)
            }
            guard let data = data else {return}
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                guard let requestResult = json["RequestResult"] as? [String: Any] else {return}
                guard let data = requestResult["DATA"] as? [String: Any] else {return}
                guard let rows = data["ROWS"] as? [[String: Any]] else {return}
                for row in rows {
                    var officeHours = OfficeHours()
                    officeHours.day = row["Day"] as? String
                    officeHours.hoursOpen = row["Open"] as? String
                    officeHours.hoursClose = row["Close"] as? String
                    availableDays.append(officeHours)
                }
                
                locationAndScheduleDetails.city = data["City"] as? String
                locationAndScheduleDetails.closeOnPublicHolidays = data["True"] as? String
                locationAndScheduleDetails.country = data["Country"] as? String
                locationAndScheduleDetails.desc = data["Desc"] as? String
                locationAndScheduleDetails.isHouseLocation = data["IsHouseLocation"] as? String
                locationAndScheduleDetails.locationOwner = data["LocationOwner"] as? String
                locationAndScheduleDetails.locationOwnerName = data["LocationOwnerName"] as? String
                locationAndScheduleDetails.name = data["Name"] as? String
                locationAndScheduleDetails.stateProvince = data["StateProvince"] as? String
                locationAndScheduleDetails.streetName = data["StreetName"] as? String
                locationAndScheduleDetails.streetNo = data["StreetNo"] as? String
                locationAndScheduleDetails.unitNo = data["UnitNo"] as? String
                locationAndScheduleDetails.userRef = data["UserRef"] as? String
                locationAndScheduleDetails.userRefName = data["UserRefName"] as? String
                locationAndScheduleDetails.zipPostalCode = data["ZipPostalCode"] as? String
                locationAndScheduleDetails.lat = data["lat"] as? String
                locationAndScheduleDetails.long = data["lng"] as? String
                
                locationAndScheduleDetails.schedule = availableDays
                completion(locationAndScheduleDetails)
            } catch let error {
                print("Handle this locationById serialization error: ", error)
            }
        }.resume()

    }
    
    func formAddressString(location: LocationAndScheduleByIdDataModel) -> String {
        guard let streetNo = location.streetNo else {return ""}
        guard let streetName =  location.streetName else {return ""}
        guard let city = location.city else {return ""}
        guard let stateProvince = location.stateProvince else {return ""}
        guard let country = location.country else {return ""}
        guard let zipcode = location.zipPostalCode else {return ""}
        let addressString = streetNo + " " + streetName + " " +  city + ", " + stateProvince + ", " + country + ", " + zipcode
        return addressString
    }

}
