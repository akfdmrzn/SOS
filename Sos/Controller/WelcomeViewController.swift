//
//  WelcomeViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 9.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if Defaults().getRefreshToken() != nil{
            NetworkManager.sendGetRequest(url: Constants.BASE_SERVICE_URL, endPoint: .CustomerRefreshToken, method: .get, parameters: [Defaults().getRefreshToken()])  { (response: BaseResponse<CustomerLoginResponseModel>) in
                
                if response.statu ?? false {
                    Defaults().saveName(data: response.dataObject!.nameSurname)
                    Defaults().saveRefreshToken(data: response.dataObject!.refreshToken)
                    Defaults().saveToken(data: response.dataObject!.token)
                    self.sosPushViewController(type: .MainViewController)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnLogin.layer.masksToBounds = true
    
        self.btnSignup.layer.cornerRadius = 5.0
        self.btnSignup.layer.masksToBounds = true
        self.btnSignup.layer.borderWidth = 1.0
        self.btnSignup.layer.borderColor = UIColor.white.cgColor
        
    }
    @IBAction func btnSignupPressed(_ sender: Any) {
    
    }
    
    @IBAction func btnLoginPressed(_ sender: Any) {
    
    }
    @IBAction func btnPressedGoToMain(_ sender: Any) {
        Defaults().saveLoginState(data: "2")
        Defaults().saveMenuState(data: "2")
        let vc = UIApplication.getTopViewController()?.sosReturnViewController(type: .MainViewController) as! MainViewController
        UIApplication.getTopViewController()?.sosPushViewController(viewController: vc)
    }
}
