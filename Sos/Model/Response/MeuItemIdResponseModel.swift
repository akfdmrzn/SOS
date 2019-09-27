//
//  MeuItemIdResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 19.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import ObjectMapper

struct MeuItemIdResponseModel : Mappable {
    var id : Int?
    var itemName : String?
    var price : Int?
    var quantity : String?
    var description : String?
    var ingredients : String?
    var categoryName : String?
    var offerNote : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["Id"]
        itemName <- map["ItemName"]
        price <- map["Price"]
        quantity <- map["Quantity"]
        description <- map["Description"]
        ingredients <- map["Ingredients"]
        categoryName <- map["CategoryName"]
        offerNote <- map["OfferNote"]
        
    }

}
