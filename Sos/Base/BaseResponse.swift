//
//  BaseResponse.swift
//  BaseProject
//
//  Created by Bekir's Mac on 19.02.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import ObjectMapper

class BaseResponse<T:Mappable >:Mappable{
    
    var statu :Bool?
    var statusCode :Int?
    var status :String?
    var message :String?
    var dataArray: [T]?
    var dataObject: T?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statu <- map["Statu"]
        statusCode <- map["StatusCode"]
        status <- map["Status"]
        message <- map["Message"]
        dataObject <- map["Data"]
        dataArray <- map["Data"]
        
    }
    
}

