//
//  UndeliveredOrdersJSONModel.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-20.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct UndeliveredOrder {
    var id: String?
    var contractNo: String?
    var memo: String?
    var policyStatusName: String?
    var orderDetails: [OrderDetails]?
    var pickupCodeImgSrc: String?
}

struct OrderDetails {
    var productName: String?
    var qty: String?
}

class UndeliveredOrdersJSONData {
    
    func fetchMyUndeliveredOrdersJSONData(completion: @escaping ([UndeliveredOrder]) -> ()) {
        
        var undeliveredOrder = UndeliveredOrder()
        var undeliveredOrders = [UndeliveredOrder]()
        var orderDetails = OrderDetails()
        var orderDetailsArray = [OrderDetails]()
        let uid = LoginController.GlobalLoginIDs.uid
        let uuid = LoginController.GlobalLoginIDs.uuid
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=MyUndeliveredOrder&uid=" + uid + "&uuid=" + uuid
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("UndeliveredOrders Error:", err)
            }
            guard let data = data else {return}

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                let requestResult = json["RequestResult"] as! [String: Any]
                if let ordersData = requestResult["DATA"] as? [String: Any] {
                    let orders = ordersData["ROWS"] as! [[String: Any]]
                    for order in orders {
                        undeliveredOrder.contractNo = order["ContractNo"] as? String
                        undeliveredOrder.id = order["Id"] as? String
                        undeliveredOrder.memo = order["Memo"] as? String
                        undeliveredOrder.pickupCodeImgSrc = order["PickupCodeImgSrc"] as? String
                        undeliveredOrder.policyStatusName = order["PolicyStatusName"] as? String
                        let items = order["OrderDetail"] as! [String: Any]
                        let itemsDetails = items["Item"] as! [[String: Any]]
                        for item in itemsDetails {
                            orderDetails.productName = item["ProductName"] as? String
                            orderDetails.qty = item["Qty"] as? String
                            orderDetailsArray.append(orderDetails)
                            undeliveredOrder.orderDetails = orderDetailsArray
                            
                        }
                        undeliveredOrders.append(undeliveredOrder)
                    }
                } else {
                    //handle error here
//                    ["RequestResult": {
//                        Action = MyUndeliveredOrder;
//                        ERROR =     {
//                            ERRORCODE = 501;
//                            ERRORLABEL = "Login_UserNotLoggedIn";
//                            ERRORMESSAGE = "User has not yet logged in.";
//                        };
//                        Params =     {
//                            "Action_get" = MyUndeliveredOrder;
//                            "uid_get" = "";
//                        };
//                        }]

                }
                
                completion(undeliveredOrders)
            } catch let err {
                print("Serialization Error:", err)
            }
            
        }.resume()
    }
    
    
    
}
