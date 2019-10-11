//
//  RegisterViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 17.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import Photos
import UserNotifications

class RegisterViewController: BaseViewController {

    @IBOutlet weak var headerView: BaseBackHeaderView!
    @IBOutlet weak var textFieldNameSurname: UITextField!
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var textFieldMail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordAgain: UITextField!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnCreateUser: UIButton!
    @IBOutlet weak var imageviewProfile: UIImageView!
    
    var imageString : String = ""
    var birthDate: Date?
    
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    var datePickerToolBar: UIView = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([cancelButton, flexSpace, doneButton], animated: false)
        return toolBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewContainer.addShadow()
        
        self.textFieldDate.delegate = self
        self.textFieldDate.inputAccessoryView = datePickerToolBar
        self.textFieldDate.inputView = datePicker
    }
    
    
    
    @objc func cancelButtonTapped() {
        self.view.endEditing(true)
        birthDate = nil
        self.textFieldDate.text = ""
    }
    
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
        birthDate = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.textFieldDate.text = formatter.string(from: datePicker.date)
    }
    
    func getBirthDayStringToSendRequest() -> String {
        if birthDate == nil {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: birthDate!)
    }
    
    @IBAction func btnPressedCreateUser(_ sender: Any) {
        
        let registerModel = CustomerRegisterRequestModel.init(email: self.textFieldMail.text ?? "", password: self.textFieldPassword.text ?? "", passwordConfirm: self.textFieldPasswordAgain.text ?? "", nameSurname: self.textFieldNameSurname.text ?? "", phoneNumber: self.textFieldPhone.text ?? "", address: self.textFieldAddress.text ?? "", birthDate: self.textFieldDate.text ?? "")
        NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .CustomerRegister,  requestModel: registerModel) { (response: BaseResponse<CustomerRegisterResponseModel>) in
            
            if response.statu ?? false {
                Defaults().saveLoginState(data: "1")
                Defaults().saveMenuState(data: "1")
                Defaults().saveName(data: response.dataObject!.nameSurname)
                Defaults().saveRefreshToken(data: response.dataObject!.refreshToken)
                Defaults().saveToken(data: response.dataObject!.token)
                
                let uploadPictureModel = UploadPictureRequestModel.init(profilePicture: self.imageString)
                
                NetworkManager.sendRequest(url: Constants.BASE_SERVICE_URL, endPoint: .UploadPicture, method: .put, requestModel: uploadPictureModel) { (response: BaseResponse<CustomerRegisterResponseModel>) in
                    if response.statu ?? false {
                        self.sosPushViewController(type: .MainViewController)
                    }
                    else{
                        self.sosPushViewController(type: .MainViewController)
                    }
                }
                
            }
            else{
                self.showAlertView(message: response.message ?? "",btnCancel: true,btnOkay: false)
            }
        }
        
    }
    
    func getCustomerRegister(){
        
    }
    @IBAction func btnPressedProfileImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func convertImageToBase64String (img: UIImage) -> String {
        let image = resizeimage(image: img, withSize: CGSize(width:200, height: 200))
        return image.pngData()!.base64EncodedString()
    }
    
    func resizeimage(image:UIImage,withSize:CGSize) -> UIImage {
        var actualHeight:CGFloat = image.size.height
        var actualWidth:CGFloat = image.size.width
        let maxHeight:CGFloat = withSize.height
        let maxWidth:CGFloat = withSize.width
        var imgRatio:CGFloat = actualWidth/actualHeight
        let maxRatio:CGFloat = maxWidth/maxHeight
        let compressionQuality = 0.5
        if (actualHeight>maxHeight||actualWidth>maxWidth) {
            if (imgRatio<maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight/actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }else if(imgRatio>maxRatio){
                // adjust height according to maxWidth
                imgRatio = maxWidth/actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }else{
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rec:CGRect = CGRect(x:0.0,y:0.0,width:actualWidth,height:actualHeight)
        UIGraphicsBeginImageContext(rec.size)
        image.draw(in: rec)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData = image.jpegData(compressionQuality: 0.75)
        UIGraphicsEndImageContext()
        let resizedimage = UIImage(data: imageData!)
        return resizedimage!
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
}
extension RegisterViewController :  UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            self.imageviewProfile.image = pickedImage
            self.imageString = self.convertImageToBase64String(img: pickedImage)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.white.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil && !textField.text!.isEmpty {
            textField.layer.borderColor = UIColor.white.cgColor
        }
        else {
            textField.layer.borderColor = UIColor.white.withAlphaComponent(0.65).cgColor
        }
    }
}
