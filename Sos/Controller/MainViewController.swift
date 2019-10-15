//
//  MainViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 10.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var headerView: BaseHeaderViewCircle!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.headerView.imageViewBackground.isHidden = true
        
    }

    @IBAction func btnOrderPressed(_ sender: Any) {
//        self.showReadQrCode()
        
        let vc = self.sosReturnViewController(type: .MenuViewController) as! MenuViewController
        vc.qrCodeTableID = 1
        vc.qrCodeRestaurantID = 1
        self.userDefaultsData.saveMenuQRCodeTableID(data: 1)
        self.userDefaultsData.saveMenuQRCodeRestaurantID(data: 1)
        self.sosPushViewController(viewController: vc)
    }
    
    func showReadQrCode(){
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr,.dataMatrix,.code128,.code39,.code93,.ean13,.ean8,.face,.pdf417]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
        
        if Defaults().getLoginState() == "1" {
            self.setLoginnedUser()
        }
        else{
            self.setNotLoginnUser()
        }
    }
    
    func setLoginnedUser(){
        self.headerView.btnLogin.isHidden = true
        self.headerView.labelLogin.isHidden = true
        
        self.headerView.btnBasket.isHidden = false
        self.headerView.labelBasket.isHidden = false
        
        self.headerView.btnLogout.isHidden = false
        self.headerView.labelLogout.isHidden = false
        
        self.headerView.btnCallService.isHidden = false
        self.headerView.labelAskService.isHidden = false
    }
    
    func setNotLoginnUser(){
        self.headerView.btnLogin.isHidden = false
        self.headerView.labelLogin.isHidden = false
        
        self.headerView.btnBasket.isHidden = true
        self.headerView.labelBasket.isHidden = true
        
        self.headerView.btnLogout.isHidden = true
        self.headerView.labelLogout.isHidden = true
        
        self.headerView.btnCallService.isHidden = true
        self.headerView.labelAskService.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
    }
    func found(code: String) {
        //Code bulundu
        var qrCodeRestaurantId : Int = 0
        var qrCodeTableId : Int = 0
        
        let jsonText = code
        var dictonary:NSDictionary?
        
        if let data = jsonText.data(using: String.Encoding.utf8) {
            
            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                
                if let myDictionary = dictonary
                {
                    qrCodeRestaurantId = myDictionary["QRCodeRestaurantId"]! as! Int
                    qrCodeTableId = myDictionary["QRCodeTableId"]! as! Int
                    
                }
            } catch let error as NSError {
                print(error)
            }

      }
        captureSession.stopRunning()
        previewLayer.removeFromSuperlayer()
        
        let vc = self.sosReturnViewController(type: .MenuViewController) as! MenuViewController
        vc.qrCodeTableID = qrCodeTableId
        vc.qrCodeRestaurantID = qrCodeRestaurantId
        self.userDefaultsData.saveMenuQRCodeTableID(data: qrCodeTableId)
        self.userDefaultsData.saveMenuQRCodeRestaurantID(data: qrCodeRestaurantId)
        self.sosPushViewController(viewController: vc)
    }
    func showAlertWithFunction(qrCode : String){
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
