//
//  CustomerChangePasswordRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerChangePasswordRequestModel : Mappable {
    
    
    var oldPassword : String?
    var newPassword : String?
    var newPasswordAgain : String?
    
    required init?(map: Map) {
        
    }
    
    init(oldPassword : String, newPassword : String, newPasswordAgain : String){
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.newPasswordAgain = newPasswordAgain
        
    }
    
    func mapping(map: Map) {
        oldPassword <- map["OldPassword"]
        newPassword <- map["NewPassword"]
        newPasswordAgain <- map["NewPasswordConfirm"]
        
    }
}
