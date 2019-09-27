//
//  ServiceEndPoint.swift
//  BaseProject
//
//  Created by Cüneyt AYVAZ on 2.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import Foundation

public enum ServiceEndPoint: String {
    
    case CustomerRegister = "/api/customer/register"
    case CustomerLogin = "/api/customer/login?Email=%0&Password=%1"
    case CustomerRefreshToken = "/api/customer/refresh-token?RefreshToken=%0"
    case Customer = "/api/customer"
    case ChangePassword = "/api/customer/change-password"
    case MenuItem = "/api/menu/menu-item"
    case MenuItemId = "/api/menu/menu-item/%0"
    case SendMessage = "/api/about/send-message"
    case UploadPicture = "/api/customer/upload-profile-picture"

}
