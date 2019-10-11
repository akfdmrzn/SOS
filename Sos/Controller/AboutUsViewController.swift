//
//  AboutUsViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 23.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {
    @IBOutlet weak var headerView: BaseBackHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.imageViewBackground.image = UIImage.init(named: "@4xbg-circle-draw")
        self.headerView.contentView.backgroundColor = UIColor.clear
    }
    

}
