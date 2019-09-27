//
//  ProfileViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 16.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var headerView: BaseBackHeaderView!
    var viewChangePassword : ChangePasswordView?
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var txtFieldMail: UITextField!
    @IBOutlet weak var txtFieldPhone: UITextField!
    @IBOutlet weak var txtFieldAdres: UITextField!
    
    @IBOutlet weak var btnUpdateInfo: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    var passwordView : ChangePasswordView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .Customer, method: .get,parameters: nil) { (response: BaseResponse<GetCustomerResponseModel>) in
            
            if response.statu ?? false {
                self.txtFieldName.text = response.dataObject?.nameSurname ?? ""
                self.txtFieldPhone.text = response.dataObject?.phoneNumber ?? ""
                self.txtFieldAdres.text = response.dataObject?.address ?? ""
                self.txtFieldDate.text = response.dataObject?.birthDate ?? ""
                self.txtFieldMail.text = response.dataObject?.email ?? ""
                self.imageViewProfile!.sd_setImage(with: URL.init(string: response.dataObject?.pictureUrl ?? ""), completed: nil)
            }
            else{
                if response.statusCode == 401{
                    self.showAlertView(message: "Lütfen Tekrar Giriş Yapın",btnCancel: false,btnOkay: true)
                }
                else{
                    self.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
                }
            }
        }
        
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
//        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
//        let image = UIImage(data: imageData ?? Data.init())
//        if (image != nil) {
//            return image!
//        }
//        return UIImage.init()
    
        let dataDecoded:NSData = NSData(base64Encoded: imageBase64String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        return decodedimage
    }
    
    @IBAction func btnPressedUpdateInfo(_ sender: Any) {
        let updateModel = UpdateUserRequestModel.init(nameSurname: self.txtFieldName.text ?? "", phoneNumber: self.txtFieldPhone.text ?? "", birthDate: self.txtFieldDate.text ?? "", address: self.txtFieldAdres.text ?? "",mail: self.txtFieldMail.text ?? "")
        NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .Customer, method: .put, requestModel: updateModel) { (response: BaseResponse<CustomerRegisterResponseModel>) in
            
            if response.statu ?? false {
                self.showAlertView(message: response.message ?? "",btnCancel: false,btnOkay: true)
            }
            else{
                if response.statusCode == 401{
                    self.showAlertView(message: "Lütfen Tekrar Giriş Yapın",btnCancel: false,btnOkay: true)
                }
                else{
                    self.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
                }
            }
        }
    }
    
    @IBAction func btnPressedChangePassword(_ sender: Any) {
        self.passwordView = ChangePasswordView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(self.passwordView!)
    }
    func showCahngePasswordView(){
        self.viewChangePassword = ChangePasswordView.init(frame: CGRect.init(x: 0, y: 0, width: (UIApplication.getTopViewController()?.view.frame.size.width)!, height: (UIApplication.getTopViewController()?.view.frame.size.height)!))
        self.view.addSubview(self.viewChangePassword!)
        
    }
    func dismissChangePassword(){
        self.viewChangePassword?.removeFromSuperview()
    }

}
