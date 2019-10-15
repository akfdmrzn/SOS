//
//  MyOrdersViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 1.10.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import ExpyTableView

class MyOrdersViewController: BaseViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var headerView: BaseBackHeaderView!
    @IBOutlet weak var tableview: ExpyTableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnPayCasa: UIButton!
    @IBOutlet weak var btnPayOnline: UIButton!
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    public static var qrCodeRestaurantId : Int = 0
    public static var qrCodeTableId : Int = 0
    
    
    
    var myOrdersResponseModel : OrderListDetailResponseModel? {
        didSet{
            self.tableview.delegate = self
            self.tableview.dataSource = self
            self.tableview.reloadData()
            self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
        }
    }
    
    override func viewDidLoad() {

        self.labelTotalPrice.text = "0.0 \(Constants.tlIconString)"
            
        self.viewContainer.addShadow()
        self.viewContainer.layer.cornerRadius = 7.0
        
        self.btnPayCasa.layer.cornerRadius = 7.0
        self.btnPayCasa.layer.masksToBounds = true
        
        self.btnPayOnline.layer.cornerRadius = 7.0
        self.btnPayOnline.layer.masksToBounds = true
        
        self.tableview.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        self.tableview.register(MyOrdersSubTableViewCell.nib, forCellReuseIdentifier: MyOrdersSubTableViewCell.identifier)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
        self.tableview.isScrollEnabled = false
        
        NetworkManager.sendHeaderRequest(url: Constants.BASE_SERVICE_URL, endPoint: .OfferList, method: .get, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"],headerValues: ["\(self.userDefaultsData.getMenuQRCodeRestaurantID() ?? 0)","\(self.userDefaultsData.getMenuQRCodeTableID() ?? 0)"]) { (response : BaseResponse<OrderListDetailResponseModel>) in
            if response.statu ?? false {
                self.myOrdersResponseModel = response.dataObject
                self.labelTotalPrice.text = "\(self.myOrdersResponseModel?.totalPrice ?? 0.0)"
            }
        }
    }
    override func viewDidLayoutSubviews() {
        self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
    }
}
extension MyOrdersViewController : ExpyTableViewDelegate,ExpyTableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrdersSubTableViewCell.identifier, for: indexPath) as! MyOrdersSubTableViewCell
        if indexPath.row == 1 {
           cell.setConfiguration(title: "Sipariş Detayı", desc: self.myOrdersResponseModel?.menuItems?[indexPath.section].itemIngredients ?? "")
        }
        else if indexPath.row == 2{
            cell.setConfiguration(title: "Sipariş Notu", desc: self.myOrdersResponseModel?.menuItems?[indexPath.section].orderNote ?? "")
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ((self.myOrdersResponseModel?.menuItems?.count ?? 0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        // This cell will be displayed at IndexPath with (section: section and row: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier) as! MenuItemTableViewCell
        cell.setConfigurationModel(name: self.myOrdersResponseModel?.menuItems?[section].itemName ?? "", price: "\(self.myOrdersResponseModel?.menuItems?[section].price ?? 0)", count: "\(self.myOrdersResponseModel?.menuItems?[section].quantity ?? 0)",alwaysPrice: self.myOrdersResponseModel?.menuItems?[section].price ?? 0.0,isDetailHidden: true,isDeletedButtonHidden: true)
             cell.qrCodeRestaurantId = self.userDefaultsData.getMenuQRCodeRestaurantID()
             cell.qrCodeTableId = self.userDefaultsData.getMenuQRCodeTableID()
             cell.orderNote = self.myOrdersResponseModel?.menuItems?[section].orderNote ?? ""
            cell.menuItemID = self.myOrdersResponseModel?.menuItems?[section].menuItem_Id ?? 0
            cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true //Return false if you want your section not to be expandable
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            UIView.animate(withDuration: 1.2, animations: {
                self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
            }) { (finished) in
            }
            
        case .willCollapse:
            print("WILL COLLAPSE")
            UIView.animate(withDuration: 1.2, animations: {
                self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
            }) { (finished) in
            }
            
        case .didExpand:
            print("DID EXPAND")
            self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
            
        case .didCollapse:
            print("DID COLLAPSE")
            self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.2, animations: {
            self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
        }) { (finished) in
        }
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
        if indexPath.row != 0 {
            
        }
        self.tableview.reloadData()
    }
}
extension MyOrdersViewController : AgainTableViewReloadDelegate{
    func againTableViewReload() {
        NetworkManager.sendHeaderRequest(url: Constants.BASE_SERVICE_URL, endPoint: .OfferList, method: .get, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"],headerValues: ["\(self.userDefaultsData.getMenuQRCodeRestaurantID() ?? 0)","\(self.userDefaultsData.getMenuQRCodeTableID() ?? 0)"]) { (response : BaseResponse<OrderListDetailResponseModel>) in
            if response.statu ?? false {
                self.myOrdersResponseModel = response.dataObject
                self.labelTotalPrice.text = "\(self.myOrdersResponseModel?.totalPrice ?? 0.0)"
            }
        }
    }
}
