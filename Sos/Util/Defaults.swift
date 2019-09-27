//
//  Defaults.swift
//  Sos
//
//  Created by Akif Demirezen on 24.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import Foundation
import ObjectMapper

public class Defaults{
    public enum DefaultsType {
        case Token
        case Name
        case Mail
        case RefreshToken
        case LoginState
        case MenuState
    }
    
    public init(){}
    
    
    
    public func clearData(){
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
    }
    
    // UserEncryptedData
    public func saveToken(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .Token))
        preferences.synchronize()
    }
    
    public func getToken() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Token)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .Token)) as! String
        return data
    }
    
    public func saveName(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .Name))
        preferences.synchronize()
    }
    
    public func getName() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Name)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .Name)) as! String
        return data
    }
    
    public func saveMail(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .Mail))
        preferences.synchronize()
    }
    
    public func getMail() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Mail)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .Mail)) as! String
        return data
    }
    
    public func saveRefreshToken(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .RefreshToken))
        preferences.synchronize()
    }
    
    public func getRefreshToken() -> String! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .RefreshToken)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .RefreshToken)) as! String
        return data
    }
    
    public func saveLoginState(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .LoginState))
        preferences.synchronize()
    }
    
    public func getLoginState() -> String! {   //1- Login olmuş kullanıcı  // 2- Hızlı geçiş yapan kullanıcı   
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .LoginState)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .LoginState)) as! String
        return data
    }
    
    public func saveMenuState(data:String){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .MenuState))
        preferences.synchronize()
    }
    
    public func getMenuState() -> String! {   // 1- QR okutulmamış   //2- QR okutulmuş
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .MenuState)) == nil {
            return nil
        }
        let data:String = preferences.value(forKey: getIdentifier(type: .MenuState)) as! String
        return data
    }
    
    private  func  getIdentifier(type:DefaultsType)->String {
        switch type {
        case .Token:
            return "Token"
        case .Name:
            return "Name"
        case .Mail:
            return "Mail"
        case .RefreshToken:
            return "RefreshToken"
        case .LoginState:
            return "LoginState"
        case .MenuState:
            return "MenuState"
        }
    }
}

