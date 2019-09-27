//
//  SendMessageRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 24.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class SendMessageRequestModel : Mappable {
    
    
    var nameSurname : String?
    var email : String?
    var phoneNumber : String?
    var message : String?
    
    required init?(map: Map) {
        
    }
    
    init(nameSurname : String, email : String, phoneNumber : String, message : String){
        self.nameSurname = nameSurname
        self.email = email
        self.phoneNumber = phoneNumber
        self.message = message
        
    }
    
    func mapping(map: Map) {
        nameSurname <- map["NameSurname"]
        email <- map["Email"]
        phoneNumber <- map["PhoneNumber"]
        message <- map["Message"]
        
    }
}
