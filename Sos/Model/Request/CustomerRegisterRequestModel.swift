//
//  CustomerRegisterRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 17.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerRegisterRequestModel: Mappable {
    
    var email : String?
    var password : String?
    var passwordConfirm : String?
    var nameSurname : String?
    var phoneNumber : String?
    var birthDate : String?
    var address : String?
    
    required init?(map: Map) {
        
    }
    
    init(email:String,password :String,passwordConfirm : String,nameSurname : String, phoneNumber : String,address : String,birthDate : String){
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.nameSurname = nameSurname
        self.phoneNumber = phoneNumber
        self.address = address
        self.birthDate = birthDate
    }
    
     func mapping(map: Map) {
        email <- map["Email"]
        password <- map["Password"]
        passwordConfirm <- map["PasswordConfirm"]
        nameSurname <- map["NameSurname"]
        phoneNumber <- map["PhoneNumber"]
        birthDate <- map["BirthDate"]
        address <- map["Address"]
        
    }
}
