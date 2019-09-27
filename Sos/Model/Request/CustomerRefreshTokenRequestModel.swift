//
//  CustomerRefreshTokenRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomerRefreshTokenRequestModel: Mappable {
    
    var refreshToken : String?
    
    required init?(map: Map) {
        
    }
    
    init(refreshToken:String){
        self.refreshToken = refreshToken
    }
    
    func mapping(map: Map) {
        refreshToken <- map["RefreshToken"]
        
    }
}
