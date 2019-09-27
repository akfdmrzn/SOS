//
//  PutCustomerRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class PutCustomerRequestModel: Mappable {
    
    var nameSurname : String?
    var phoneNumber : String?
    var birthDate : String?
    var address : String?
    // add profile picture
    required init?(map: Map) {
        
    }
    
    init(nameSurname : String, phoneNumber : String,address : String,birthDate : String){
        self.nameSurname = nameSurname
        self.phoneNumber = phoneNumber
        self.address = address
        self.birthDate = birthDate
    }
    
    func mapping(map: Map) {
        nameSurname <- map["NameSurname"]
        phoneNumber <- map["PhoneNumber"]
        birthDate <- map["BirthDate"]
        address <- map["Address"]
        
    }
}
