//
//  UpdateUserRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 24.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateUserRequestModel : Mappable {
    
    
    var nameSurname : String?
    var phoneNumber : String?
    var birthDate : String?
    var address : String?
    var mail : String?
    
    required init?(map: Map) {
        
    }
    
    init(nameSurname : String, phoneNumber : String, birthDate : String, address : String,mail : String){
        self.nameSurname = nameSurname
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.address = address
        self.mail = mail
    }
    
    func mapping(map: Map) {
        nameSurname <- map["NameSurname"]
        phoneNumber <- map["PhoneNumber"]
        birthDate <- map["BirthDate"]
        address <- map["Address"]
        mail <- map["Email"]
        
    }
}
