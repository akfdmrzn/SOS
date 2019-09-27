//
//  ExtensionImageView.swift
//  Sos
//
//  Created by Akif Demirezen on 20.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

    func setImageWithLink(link : String) {
        let fullLink : String = "services.speedyorderservice.com/\(link)"
        self.sd_setImage(with: URL.init(string: fullLink), completed: nil)
    }
}
