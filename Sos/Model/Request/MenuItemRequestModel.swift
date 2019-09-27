//
//  MenuItemRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class MenuItemRequestModel : Mappable {

    
    var qrCodeRestaurantId : Int?
    var qrCodeTableId : Int?
    
    required init?(map: Map) {
        
    }
    
    init(qrCodeRestaurantId : Int, qrCodeTableId : Int){
        self.qrCodeRestaurantId = qrCodeRestaurantId
        self.qrCodeTableId = qrCodeTableId
        
    }
    
    func mapping(map: Map) {
        qrCodeTableId <- map["QRCodeTableId"]
        qrCodeRestaurantId <- map["QRCodeRestaurantId"]
        
    }
}
