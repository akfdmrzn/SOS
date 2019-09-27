//
//  ChangePassswordPopup.swift
//  Sos
//
//  Created by Akif Demirezen on 16.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class ChangePasswordView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var txtFieldOldPassword: UITextField!
    @IBOutlet weak var txtFieldNewPassword: UITextField!
    @IBOutlet weak var txtFieldAgain: UITextField!
    @IBOutlet weak var btnChange: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupThisView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThisView()
    }
    @IBAction func btnPressedChange(_ sender: Any) {
        let changePasswordModel = CustomerChangePasswordRequestModel.init(oldPassword: self.txtFieldOldPassword.text ?? "", newPassword: self.txtFieldNewPassword.text ?? "", newPasswordAgain: self.txtFieldAgain.text ?? "")
        NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .ChangePassword, method: .put, requestModel: changePasswordModel) { (response: BaseResponse<CustomerRegisterResponseModel>) in
            let vc = UIApplication.getTopViewController() as! BaseViewController
            if response.statu ?? false {
                vc.showAlertView(message: response.message ?? "",btnCancel: false,btnOkay: true)
                self.removeFromSuperview()
            }
            else{
                if response.statusCode == 401{
                   vc.showAlertView(message: "Lütfen Tekrar Giriş Yapın",btnCancel: false,btnOkay: true)
                }
                else{
                   vc.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
                }
            }
        }
    }
    
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: ChangePasswordView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
}

