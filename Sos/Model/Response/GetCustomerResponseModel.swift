//
//  GetCustomerResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCustomerResponseModel: Mappable {
    
    var nameSurname : String = ""
    var pictureUrl : String = ""
    var email : String = ""
    var phoneNumber : String = ""
    var address : String = ""
    var birthDate : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nameSurname <- map["NameSurname"]
        pictureUrl <- map["PictureUrl"]
        email <- map["Email"]
        phoneNumber <- map["PhoneNumber"]
        pictureUrl <- map["PictureUrl"]
        birthDate <- map["BirthDate"]
        address <- map["Address"]
    }
}
