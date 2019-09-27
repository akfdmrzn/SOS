//
//  CustomerLoginRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerLoginRequestModel: Mappable {
    
    var email : String?
    var password : String?
    
    required init?(map: Map) {
        
    }
    
    init(email:String,password : String){
        self.email = email
        self.password = password
    }
    
    func mapping(map: Map) {
        email <- map["Email"]
        password <- map["Password"]
        
    }
}
