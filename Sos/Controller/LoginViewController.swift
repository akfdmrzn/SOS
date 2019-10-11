//
//  LoginViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 9.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewUsername: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogin.layer.cornerRadius = 5.0
        self.btnLogin.layer.masksToBounds = true
        self.btnLogin.layer.borderColor = UIColor.white.cgColor
        self.btnLogin.layer.borderWidth = 1.0
        
        self.viewUsername.layer.borderColor = UIColor.white.cgColor
        self.viewUsername.layer.borderWidth = 1.0
        self.viewUsername.layer.cornerRadius = 10.0
        self.viewUsername.layer.masksToBounds = false
        self.txtFieldUsername.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı",            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        
        self.viewPassword.layer.borderColor = UIColor.white.cgColor
        self.viewPassword.layer.borderWidth = 1.0
        self.viewPassword.layer.cornerRadius = 10.0
        self.viewPassword.layer.masksToBounds = false
        self.txtFieldPassword.attributedPlaceholder = NSAttributedString(string: "Parolanız",                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.txtFieldUsername.text = ""
        self.txtFieldPassword.text = ""
    }
    
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        NetworkManager.sendGetRequest(url: Constants.BASE_SERVICE_URL, endPoint: .CustomerLogin, method: .get, parameters: [self.txtFieldUsername.text ?? "",self.txtFieldPassword.text ?? ""])  { (response: BaseResponse<CustomerLoginResponseModel>) in
            
            if response.statu ?? false {
                Defaults().saveLoginState(data: "1")
                Defaults().saveMenuState(data: "1")
                Defaults().saveName(data: response.dataObject!.nameSurname)
                Defaults().saveRefreshToken(data: response.dataObject!.refreshToken)
                Defaults().saveToken(data: response.dataObject!.token)
                self.sosPushViewController(type: .MainViewController)
            }
            else{
                self.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
            }
        }
    }
    @IBAction func btnRegisterPressed(_ sender: Any) {
        
    }
    
}
