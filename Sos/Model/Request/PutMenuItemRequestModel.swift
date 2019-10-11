//
//  PutMenuItemRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 8.10.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class PutMenuItemRequestModel : Mappable {
    
    var menuItemId : Int = 0
    var quantity : Int = 0
    var offerNote : String = ""
    
    required init?(map: Map) {
        
    }
    
    init(menuItemId : Int,quantity : Int,offerNote : String){
        self.menuItemId = menuItemId
        self.quantity = quantity
        self.offerNote = offerNote
    }
    
    func mapping(map: Map) {
        menuItemId <- map["MenuItem_Id"]
        quantity <- map["Quantity"]
        offerNote <- map["OfferNote"]
    }
}
