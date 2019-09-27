//
//  ConnectionViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 23.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class ConnectionViewController: BaseViewController {
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldMail: UITextField!
    @IBOutlet weak var txtFieldPhone: UITextField!
    @IBOutlet weak var txtFieldMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var headerView: BaseBackHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnSend.layer.cornerRadius = 7.0
        self.btnSend.layer.masksToBounds = true
        
        self.headerView.imageViewBackground.image = UIImage.init(named: "@4xbg-circle-draw")
        self.headerView.contentView.backgroundColor = UIColor.clear
    }
    
    @IBAction func btnPeessedSend(_ sender: Any) {
        let sendMessageModel = SendMessageRequestModel.init(nameSurname: self.txtFieldName.text ?? "", email: self.txtFieldMail.text ?? "", phoneNumber: self.txtFieldPhone.text ?? "", message: self.txtFieldMessage.text ?? "")
        NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .SendMessage,  requestModel: sendMessageModel) { (response: BaseResponse<CustomerRegisterResponseModel>) in
            
            if response.statu ?? false {
                self.showAlertView(message: response.message ?? "",btnCancel: false,btnOkay: true)
            }
            else{
                self.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
            }
        }
    }
}
