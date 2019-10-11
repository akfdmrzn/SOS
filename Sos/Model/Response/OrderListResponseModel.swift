//
//  OrderListResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 10.10.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import ObjectMapper

struct OrderListResponseModel : Mappable {
    var orderId : Int?
    var orderTime : Int?
    var orderStatusName : Double?
    var paymentTypeName : String?
    var totalPrice : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        orderId <- map["Order_Id"]
        orderTime <- map["OrderTime"]
        orderStatusName <- map["OrderStatusName"]
        paymentTypeName <- map["PaymentTypeName"]
        totalPrice <- map["TotalPrice"]
        
    }
}
