//
//  MenuItemIdRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 19.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class MenuItemIdRequestModel : Mappable {
    
    
    var id : Int?
    
    required init?(map: Map) {
        
    }
    
    init(id : Int){
        self.id = id
        
    }
    
    func mapping(map: Map) {
        id <- map["Id"]
        
    }
}
