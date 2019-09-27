//
//  MenuItemResponseModel.swift
//  Sos
//
//  Created by Akif Demirezen on 18.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

struct MenuItemResponseModel : Mappable {
    var restaurant : Restaurant?
    var categoryItems : [CategoryItems]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        restaurant <- map["Restaurant"]
        categoryItems <- map["CategoryItems"]
    }
    
}

public class MenuItems : Mappable {
    var id : Int?
    var itemName : String?
    var itemIngredients : String?
    var price : Int?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        id <- map["Id"]
        itemName <- map["ItemName"]
        itemIngredients <- map["ItemIngredients"]
        price <- map["Price"]
    }
    
}
struct Restaurant : Mappable {
    var id : Int?
    var coverImageUrl : String?
    var restaurantName : String?
    var restaurantShortDescription : String?
    var restaurantLogoImageUrl : String?
    var rate : Int?
    var restaurantTypeName : String?
    var openingHours : String?
    var closingHours : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        coverImageUrl <- map["CoverImageUrl"]
        restaurantName <- map["RestaurantName"]
        restaurantShortDescription <- map["RestaurantShortDescription"]
        restaurantLogoImageUrl <- map["RestaurantLogoImageUrl"]
        rate <- map["Rate"]
        restaurantTypeName <- map["RestaurantTypeName"]
        openingHours <- map["OpeningHours"]
        closingHours <- map["ClosingHours"]
    }
    
}

struct CategoryItems : Mappable {
    var id : Int?
    var categoryName : String?
    var categoryImageUrl : String?
    var menuItems : [MenuItems]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["Id"]
        categoryName <- map["CategoryName"]
        categoryImageUrl <- map["CategoryImageUrl"]
        menuItems <- map["MenuItems"]
    }
    
}
