//
//  DeliveredOrders.swift
//  EggMap
//
//  Created by Mei on 2018-08-22.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation

struct DeliveredOrder {
    var id: String?
    var contractNo: String?
    var memo: String?
    var policyStatusName: String?
    var orderDetails: [OrderDetails]?
}



class DeliveredOrdersJSONData {
    
    func fetchMyDeliveredOrdersJSONData(completion: @escaping ([DeliveredOrder]) -> ()) {
        var deliveredOrder = DeliveredOrder()
        var deliveredOrders = [DeliveredOrder]()
        let uid = LoginController.GlobalLoginIDs.uid
        let uuid = LoginController.GlobalLoginIDs.uuid
        let urlString = "http://shoptraining.xbo-m.com/" + "/DataSource/Mobile/?Action=MyDeliveredOrder&uid=" + uid + "&uuid=" + uuid
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("DeliveredOrders Error:", err)
            }
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                let requestResult = json["RequestResult"] as! [String: Any]
                let ordersData = requestResult["DATA"] as! [String: Any]
                let orders = ordersData["ROWS"] as! [[String: Any]]
                for order in orders {
                    deliveredOrder.contractNo = order["ContractNo"] as? String
                    deliveredOrder.id = order["Id"] as? String
                    deliveredOrder.memo = order["Memo"] as? String
                    deliveredOrder.policyStatusName = order["PolicyStatusName"] as? String
                    let items = order["OrderDetail"] as! [String: Any]
                    let itemsDetails = items["Item"] as! [[String: Any]]
                    for item in itemsDetails {
                        var itemDetail  = OrderDetails()
                        itemDetail.productName = item["ProductName"] as? String
                        itemDetail.qty = item["Qty"] as? String
                        var itemDetailsArray = [OrderDetails]()
                        itemDetailsArray.append(itemDetail)
                        deliveredOrder.orderDetails = itemDetailsArray

                    }
                    deliveredOrders.append(deliveredOrder)
                }
                completion(deliveredOrders)
            } catch let err {
                print("Serialization Error:", err)
            }
            
            }.resume()
    }
    
    
    
}
