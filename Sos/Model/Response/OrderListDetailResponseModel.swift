//
//  OrderListDetailResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 10.10.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import ObjectMapper

struct OrderListDetailResponseModel : Mappable {
    var order_Id : Int?
    var orderStatus_Id : Int?
    var orderStatusName : String?
    var paymentType_Id : Int?
    var paymentTypeName : String?
    var totalPrice : Double?
    var discount : Double?
    var finalPrice : Double?
    var menuItems : [MenuItemsOrder]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        order_Id <- map["Order_Id"]
        orderStatus_Id <- map["OrderStatus_Id"]
        orderStatusName <- map["OrderStatusName"]
        paymentType_Id <- map["PaymentType_Id"]
        paymentTypeName <- map["PaymentTypeName"]
        totalPrice <- map["TotalPrice"]
        discount <- map["Discount"]
        finalPrice <- map["FinalPrice"]
        menuItems <- map["MenuItems"]
    }

}

struct MenuItemsOrder : Mappable {
    var menuItem_Id : Int?
    var itemName : String?
    var itemIngredients : String?
    var orderNote : String?
    var price : Double?
    var quantity : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        menuItem_Id <- map["MenuItem_Id"]
        itemName <- map["ItemName"]
        itemIngredients <- map["ItemIngredients"]
        orderNote <- map["OrderNote"]
        price <- map["Price"]
        quantity <- map["Quantity"]
    }

}
