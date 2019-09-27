//
//  Util.swift
//  BaseProject
//
//  Created by Bekir's Mac on 23.01.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import UIKit
import Alamofire

class Util {
    
    static func goToWeb(url: String) {
        guard let urlLink = URL(string: url) else { return }
        UIApplication.shared.open(urlLink)
    }
    
//    static func goToWebView(url: String) {
//        if url.isEmpty {
//            return
//        }
//        let vc = WebViewController()
//        vc.url = url
//        UIApplication.getTopViewController()?.otiPushViewController(viewController: vc)
//    }
    
    static func downloadFile(url: String, successHandler: @escaping (URL) -> (), failHandler: @escaping (Error) -> ()) {
        guard let fileUrl = URL(string: url) else { return }
        
        guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationURL = documentsPath.appendingPathComponent(fileUrl.lastPathComponent)

        do {
            try FileManager.default.removeItem(at: destinationURL)
        }
        catch let error {
            debugPrint(error.localizedDescription)
        }

        let destination = DownloadRequest.suggestedDownloadDestination()
        Alamofire.download(url, to: destination).response { response in

            if response.error == nil && response.destinationURL != nil {
                successHandler(response.destinationURL!)
            }
            else if response.error != nil {
                failHandler(response.error!)
            }
        }
    }
    
    static func callNumber(phoneNumber: String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber.replacingOccurrences(of: " ", with: ""))") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    static func findDateInfo(stringDate : String)->Date {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: stringDate)
        let dateStr = dateFormatter.string(from: date!)
        let dateComp = dateFormatter.date(from: dateStr)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day ,.weekday], from: dateComp!)
        let finalDate = calendar.date(from:components)!
        
        return finalDate
    }
    
    
}

