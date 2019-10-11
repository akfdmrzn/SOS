//
//  BaseViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 23.08.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var leftMenuView : LeftMenuView?
    var alertView : AlertView?
    let userDefaultsData:Defaults = Defaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle  = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showAlertView(message : String,btnCancel : Bool,btnOkay : Bool){
        self.alertView = AlertView.init(frame: CGRect.init(x: 0, y: 0, width: (UIApplication.getTopViewController()?.view.frame.size.width)!, height: (UIApplication.getTopViewController()?.view.frame.size.height)!))
        self.alertView?.labelMessage.text = message
        self.alertView?.btnCancel.isHidden = true
        self.alertView?.btnConfirm.isHidden = true
        if btnCancel {
            self.alertView?.btnCancel.isHidden = false
        }
        if btnOkay {
            self.alertView?.btnConfirm.isHidden = false
        }
        self.view.addSubview(self.alertView!)
    }
    
    func dismissAlertView(){
        self.alertView?.removeFromSuperview()
    }
    
}


