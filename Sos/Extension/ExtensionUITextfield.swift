//
//  ExtensionUITextfield.swift
//  Sos
//
//  Created by Akif Demirezen on 27.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable var customPlaceHolder: String? {
        get {
            return self.customPlaceHolder
        }
        set {
             let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 193.0/255.0, green: 209.0/255.0, blue: 217.0/255.0, alpha: 0.7)]
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder! ,attributes:attributeDict)
        }
    }
}
