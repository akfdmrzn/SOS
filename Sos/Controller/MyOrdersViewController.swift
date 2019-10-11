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
    
    override func viewDidLoad() {

        self.viewContainer.addShadow()
        
        self.btnPayCasa.layer.cornerRadius = 7.0
        self.btnPayCasa.layer.masksToBounds = true
        
        self.btnPayOnline.layer.cornerRadius = 7.0
        self.btnPayOnline.layer.masksToBounds = true
        
        self.tableview.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        self.tableview.register(MyOrdersSubTableViewCell.nib, forCellReuseIdentifier: MyOrdersSubTableViewCell.identifier)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.estimatedRowHeight = 70
        self.tableview.reloadData()
        self.tableview.isScrollEnabled = false
        self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
        
        NetworkManager.sendGetRequest(url: Constants.BASE_SERVICE_URL, endPoint: .OrderList, method: .get, parameters: [""]) { (response : BaseResponse<OrderListResponseModel>) in
            if response.statu ?? false {
                NetworkManager.sendGetRequest(url: Constants.BASE_SERVICE_URL, endPoint: .OrderListDetail, method: .get, parameters: ["\(response.dataArray?.first?.orderId ?? 1)"]) { (response : BaseResponse<OrderListDetailResponseModel>) in
                    if response.statu ?? false {
                        
                    }
                }
            }
        }
}
    override func viewDidLayoutSubviews() {
        print("")
    }
}
extension MyOrdersViewController : ExpyTableViewDelegate,ExpyTableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrdersSubTableViewCell.identifier, for: indexPath) as! MyOrdersSubTableViewCell
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        // This cell will be displayed at IndexPath with (section: section and row: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier) as! MenuItemTableViewCell
        cell.setConfigurationModel(name: "akif", price: "1230", count: "2",alwaysPrice: 3,isDetailHidden: true)
        return cell
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true //Return false if you want your section not to be expandable
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 92.0
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        UIView.animate(withDuration: 1.2, animations: {
            self.tableViewHeightConstraint.constant = (self.tableview.contentSize.height)
        }) { (finished) in
        }
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            
        case .willCollapse:
            print("WILL COLLAPSE")
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            print("DID COLLAPSE")
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
    }
    
}
