//
//  LocalizedPListStringGetter.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-09-10.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct Localizer: Decodable {
    
}

struct LocalizationPlist : Decodable{
    private enum CodingKeys: String, CodingKey {
        case username, password, rememberMe, login, menu, readyForPickup, delivered, editProfile, orderSummary, xboMarketShop, earningsSummary, scanTool, logout, location, tapHere, status, available, unavailable, editHours, monday, tuesday, wednesday, thursday, friday, saturday, sunday, close, email, phone, address, copy, retake, qrCode, enterMessage, mic, send, map, ordersTaken
    }
    let username: Username?
    let password: Password?
    let rememberMe: RememberMe?
    let login: Login?
    let menu: Menu?
    let readyForPickup: ReadyForPickup?
    let delivered: Delivered?
    let editProfile: EditProfile?
    let orderSummary: OrderSummary?
    let xboMarketShop: XBOMarketShop?
    let earningsSummary: EarningsSummary?
    let scanTool: ScanTool?
    let logout: Logout?
    let location: LocationText?
    let tapHere: TapHere?
    let status: Status?
    let available: Available?
    let unavailable: Unavailable?
    let editHours: EditHours?
    let monday: Monday?
    let tuesday: Tuesday?
    let wednesday: Wednesday?
    let thursday: Thursday?
    let friday: Friday?
    let saturday: Saturday?
    let sunday: Sunday?
    let close: Close?
    let email: Email?
    let phone: Phone?
    let address: Address?
    let copy: Copy?
    let retake: Retake?
    let qrCode: QRCode?
    let enterMessage: EnterMessage?
    let mic: Mic?
    let send: Send?
    let map: Map?
    let ordersTaken: OrdersTaken?
}

struct Username: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Password: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct RememberMe: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Login: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Menu: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct ReadyForPickup: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Delivered: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct EditProfile: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct OrderSummary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct XBOMarketShop: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct EarningsSummary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct ScanTool: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Logout: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct LocationText : Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct TapHere : Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Status: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Available: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Unavailable: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct EditHours: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Monday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Tuesday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Wednesday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Thursday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Friday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Saturday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Sunday: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Close: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Email: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Phone: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Address: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Retake: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Copy: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct QRCode: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct EnterMessage: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Mic: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Send: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct Map: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}

struct OrdersTaken: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value, comment
    }
    let value: String?
    let comment: String?
}


class LocalizedPListStringGetter {
    static let shareInstance = LocalizedPListStringGetter()
    
    func parseLocalizable() -> LocalizationPlist {
        if let path = Bundle.main.url(forResource: "Localizable", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: path)
                let decoder = PropertyListDecoder()
                let decodedPlist = try decoder.decode(LocalizationPlist.self, from: data)
                print("PRINT THIS SHIT!!!!: ", decodedPlist)
                return decodedPlist
                
            } catch let err {
                print(err)
                return LocalizationPlist(username: Username(value: "", comment: ""), password: Password(value: "", comment: ""), rememberMe: RememberMe(value: "", comment: ""), login: Login(value: "", comment: ""), menu: Menu(value: "", comment: ""), readyForPickup: ReadyForPickup(value: "", comment: ""), delivered: Delivered(value: "", comment: ""), editProfile: EditProfile(value: "", comment: ""), orderSummary: OrderSummary(value: "", comment: ""), xboMarketShop: XBOMarketShop(value: "", comment: ""), earningsSummary: EarningsSummary(value: "", comment: ""), scanTool: ScanTool(value: "", comment: ""), logout: Logout(value: "", comment: ""), location: LocationText(value: "", comment: ""), tapHere: TapHere(value: "", comment: ""), status: Status(value: "", comment: ""), available: Available(value: "", comment: ""), unavailable: Unavailable(value: "", comment: ""), editHours: EditHours(value: "", comment: ""), monday: Monday(value: "", comment: ""), tuesday: Tuesday(value: "", comment: ""), wednesday: Wednesday(value: "", comment: ""), thursday: Thursday(value: "", comment: ""), friday: Friday(value: "", comment: ""), saturday: Saturday(value: "", comment: ""), sunday: Sunday(value: "", comment: ""), close: Close(value: "", comment: ""), email: Email(value: "", comment: ""), phone: Phone(value: "", comment: ""), address: Address(value: "", comment: ""), copy: Copy(value: "", comment: ""), retake: Retake(value: "", comment: ""), qrCode: QRCode(value: "", comment: ""), enterMessage: EnterMessage(value: "", comment: ""), mic: Mic(value: "", comment: ""), send: Send(value: "", comment: ""), map: Map(value: "", comment: ""), ordersTaken: OrdersTaken(value: "", comment: ""))

            }
            
        }
        return LocalizationPlist(username: Username(value: "", comment: ""), password: Password(value: "", comment: ""), rememberMe: RememberMe(value: "", comment: ""), login: Login(value: "", comment: ""), menu: Menu(value: "", comment: ""), readyForPickup: ReadyForPickup(value: "", comment: ""), delivered: Delivered(value: "", comment: ""), editProfile: EditProfile(value: "", comment: ""), orderSummary: OrderSummary(value: "", comment: ""), xboMarketShop: XBOMarketShop(value: "", comment: ""), earningsSummary: EarningsSummary(value: "", comment: ""), scanTool: ScanTool(value: "", comment: ""), logout: Logout(value: "", comment: ""), location: LocationText(value: "", comment: ""), tapHere: TapHere(value: "", comment: ""), status: Status(value: "", comment: ""), available: Available(value: "", comment: ""), unavailable: Unavailable(value: "", comment: ""), editHours: EditHours(value: "", comment: ""), monday: Monday(value: "", comment: ""), tuesday: Tuesday(value: "", comment: ""), wednesday: Wednesday(value: "", comment: ""), thursday: Thursday(value: "", comment: ""), friday: Friday(value: "", comment: ""), saturday: Saturday(value: "", comment: ""), sunday: Sunday(value: "", comment: ""), close: Close(value: "", comment: ""), email: Email(value: "", comment: ""), phone: Phone(value: "", comment: ""), address: Address(value: "", comment: ""), copy: Copy(value: "", comment: ""), retake: Retake(value: "", comment: ""), qrCode: QRCode(value: "", comment: ""), enterMessage: EnterMessage(value: "", comment: ""), mic: Mic(value: "", comment: ""), send: Send(value: "", comment: ""), map: Map(value: "", comment: ""), ordersTaken: OrdersTaken(value: "", comment: ""))
    }
}
