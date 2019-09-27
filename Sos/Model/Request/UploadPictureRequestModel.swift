//
//  UploadPictureRequestModel.swift
//  Sos
//
//  Created by Akif Demirezen on 25.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

class UploadPictureRequestModel : Mappable {
    
    var profilePicture : String?
    
    required init?(map: Map) {
        
    }
    
    init(profilePicture : String){
        self.profilePicture = profilePicture
    }
    
    func mapping(map: Map) {
        profilePicture <- map["ProfilePicture"]
        
    }
}
