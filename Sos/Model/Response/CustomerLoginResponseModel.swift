//
//  CustomerLoginResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerLoginResponseModel: Mappable {
    
    var nameSurname : String = ""
    var pictureUrl : String = ""
    var token : String = ""
    var refreshToken : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nameSurname <- map["NameSurname"]
        pictureUrl <- map["PictureUrl"]
        token <- map["Token"]
        refreshToken <- map["RefreshToken"]
    }
}
