//
//  MenuItemTableViewCell.swift
//  Sos
//
//  Created by Akif Demirezen on 13.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var imageViewDetail: UIImageView!
    
    var alwaysPrice : Double = 0
    var qrCodeRestaurantId : Int = 0
    var qrCodeTableId : Int = 0
    var menuItemID : Int = 0
    var orderNote : String = ""
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnPressedDelete(_ sender: Any) {
        let putAddMenuItemModel = PutMenuItemRequestModel.init(menuItemId: self.menuItemID, quantity: Int(self.labelCount.text!)! - 1, offerNote: self.orderNote)
        NetworkManager.sendHeaderAndBodyRequest(url: Constants.BASE_SERVICE_URL, endPoint: .DeleteMenuItemId, method: .delete, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"], headerValues: [String(self.qrCodeRestaurantId),String(self.qrCodeTableId)], requestJsonModel: putAddMenuItemModel,parameters: ["\(self.menuItemID)"]) { (response : BaseResponse<MenuItemResponseModel>) in
            if response.statu ?? false {
                
            }
        }
    }
    @IBAction func btnPressedDecrease(_ sender: Any) {
        if Int(self.labelCount.text!)! == 1 {
            
        }
        else{
            let putAddMenuItemModel = PutMenuItemRequestModel.init(menuItemId: self.menuItemID, quantity: Int(self.labelCount.text!)! - 1, offerNote: self.orderNote)
            NetworkManager.sendHeaderAndBodyRequest(url: Constants.BASE_SERVICE_URL, endPoint: .PutMenuItem, method: .put, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"], headerValues: [String(self.qrCodeRestaurantId),String(self.qrCodeTableId)], requestJsonModel: putAddMenuItemModel) { (response : BaseResponse<MenuItemResponseModel>) in
                if response.statu ?? false {
                    self.labelCount.text = String(Int(self.labelCount.text!)! - 1)
                    self.labelPrice.text = String("\(Constants.tlIconString) \(self.alwaysPrice) * \((Double(self.labelCount.text!)!))")
                }
            }
        }
    }
    @IBAction func btnPressedIncrease(_ sender: Any) {
        
        let putAddMenuItemModel = PutMenuItemRequestModel.init(menuItemId: self.menuItemID, quantity: Int(self.labelCount.text!)! + 1, offerNote: self.orderNote)
        NetworkManager.sendHeaderAndBodyRequest(url: Constants.BASE_SERVICE_URL, endPoint: .PutMenuItem, method: .put, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"], headerValues: [String(self.qrCodeRestaurantId),String(self.qrCodeTableId)], requestJsonModel: putAddMenuItemModel) { (response : BaseResponse<MenuItemResponseModel>) in
            if response.statu ?? false {
                self.labelCount.text = String(Int(self.labelCount.text!)! + 1)
                self.labelPrice.text = String("\(Constants.tlIconString) \(self.alwaysPrice) * \((Double(self.labelCount.text!)!))")
            }
        }
    }
    
    func setConfigurationModel(name:String,price : String,count : String,alwaysPrice : Double) {
        self.labelName.text = name
        self.labelPrice.text = price
        self.labelCount.text = count
        self.alwaysPrice = alwaysPrice
    }
    
    func setConfigurationModel(name:String,price : String,count : String,alwaysPrice : Double,isDetailHidden : Bool) {
           self.labelName.text = name
           self.labelPrice.text = price
           self.labelCount.text = count
           self.alwaysPrice = alwaysPrice
           self.btnDetail.isHidden = !isDetailHidden
           self.labelDetail.isHidden = !isDetailHidden
           self.imageViewDetail.isHidden = !isDetailHidden
       }
}
