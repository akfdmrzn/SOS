//
//  NetworkManager.swift
//  BaseProject
//
//  Created by Cüneyt AYVAZ on 2.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public class NetworkManager {
    
    private static let TIMEOUT_INTERVAL: TimeInterval = 300
    
    public static func sendRequest<T: Mappable>(url: String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, requestModel: Mappable, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, requestModel: requestModel),
            let viewController = UIApplication.getTopViewController()
            else {
                return
        }
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    public static func sendRequest<T: Mappable>(url : String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, parameters: Parameters? = nil, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, parameters: parameters),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    private static func prepareRequest(url : String,endPoint: ServiceEndPoint, method: HTTPMethod, requestModel: Mappable) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestModel.toJSON(),options: .prettyPrinted)
        
        let token = Defaults().getToken()
        request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private static func prepareRequest(url: String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: Parameters? = nil) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        let token = Defaults().getToken()
        request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        if parameters != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!)
        }
        
        return request
    }
    
    public static func sendGetRequest<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: [String], indicatorEnabled: Bool = true,
                                            completion: @escaping(T) -> ()) {
        
        var urlPath = url + endPoint.rawValue
        
        for i in 0...parameters.count - 1{
            urlPath = urlPath.replacingOccurrences(of: "%\(i)", with: parameters[i])
        }
        
        var requestModel = URLRequest(url: URL(string: urlPath)!)
        requestModel.timeoutInterval = TIMEOUT_INTERVAL
        requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestModel.httpMethod = method.rawValue
        
        let token = Defaults().getToken()
        requestModel.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let request = requestModel
        let viewController = UIApplication.getTopViewController()
        
        
        if indicatorEnabled {
            viewController!.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController!.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    public static func sendHeaderRequest<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, headerKeys: [String],headerValues: [String], indicatorEnabled: Bool = true,
                                                   completion: @escaping(T) -> ()) {
        
        let urlPath = url + endPoint.rawValue
        var requestModel = URLRequest(url: URL(string: urlPath)!)
        requestModel.timeoutInterval = TIMEOUT_INTERVAL
        requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestModel.httpMethod = method.rawValue
        
        for i in 0...headerKeys.count - 1{
           requestModel.addValue(headerValues[i], forHTTPHeaderField: headerKeys[i])
        }
        
        
        let request = requestModel
        let viewController = UIApplication.getTopViewController()
        
        
        if indicatorEnabled {
            viewController!.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController!.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
}
