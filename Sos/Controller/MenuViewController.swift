//
//  MenuViewController.swift
//  Sos
//
//  Created by Akif Demirezen on 10.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import ExpyTableView

class MenuViewController: BaseViewController {

    @IBOutlet weak var tableView: ExpyTableView!
    @IBOutlet weak var viewRestaurant: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelRestaurantName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var imageviewRestaurant: UIImageView!
    
    
    
    var orderView : OrderInfoView?
    var alphaView : UIView?
    
    var qrCodeRestaurantID = 0
    var qrCodeTableID = 0
    
    var tapGestureAlpha : UITapGestureRecognizer?
    var menuItemResponseModel : MenuItemResponseModel? {
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
            self.labelRestaurantName.text = self.menuItemResponseModel?.restaurant?.restaurantName
            self.labelDesc.text = self.menuItemResponseModel?.restaurant?.restaurantShortDescription
            self.labelRate.text = "\(self.menuItemResponseModel?.restaurant?.rate ?? 0)"
            self.labelType.text = self.menuItemResponseModel?.restaurant?.restaurantTypeName
            self.labelHours.text = "\(self.menuItemResponseModel?.restaurant?.openingHours ?? "") - \(self.menuItemResponseModel?.restaurant?.closingHours ?? "")"
            self.imageviewRestaurant.sd_setImage(with: URL.init(string: self.menuItemResponseModel?.restaurant?.restaurantLogoImageUrl ?? ""), completed: nil)
            self.imageViewBackground.sd_setImage(with: URL.init(string: self.menuItemResponseModel?.restaurant?.coverImageUrl ?? ""), completed: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.viewRestaurant.layer.cornerRadius = 7.0
        self.viewRestaurant.layer.masksToBounds = true
        self.viewRestaurant.addShadow()
        
        self.tableView.register(MenuSubTableViewCell.nib, forCellReuseIdentifier: MenuSubTableViewCell.identifier)
        self.tableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
        
        NetworkManager.sendHeaderRequest(url: Constants.BASE_SERVICE_URL, endPoint: .MenuItem, method: .get, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"],headerValues: [String(self.qrCodeRestaurantID),String(self.qrCodeTableID)])  { (response: BaseResponse<MenuItemResponseModel>) in

            if response.statu ?? false {
                self.menuItemResponseModel = response.dataObject ?? MenuItemResponseModel.init(JSONString: "{}")
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        print("")
        self.tableView.reloadData()
    }
  
    @objc func showOrderMenu(name : String,count : String,price : Double,menuItemId : Int){
        
        self.orderView = OrderInfoView.init(frame: CGRect.init(x: (UIApplication.getTopViewController()?.view.frame.size.width)!, y: 80, width: ((UIApplication.getTopViewController()?.view.frame.size.width)! - 40), height: (((UIApplication.getTopViewController()?.view.frame.size.height)!) / 2) + 50))
        self.orderView?.name = name
        self.orderView?.count = count
        self.orderView?.price = String(price)
        self.orderView?.btnDissmissView.addTarget(self, action: #selector(dissMissOrderMenu), for: .touchDown)
        self.alphaView = UIView.init(frame: (UIApplication.getTopViewController()?.view.frame)!)
        self.alphaView?.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        self.alphaView!.addSubview(self.orderView!)
        self.orderView?.heightTableViewConstraint.constant = (self.orderView?.tableView.contentSize.height)!
        self.orderView?.tableView.isScrollEnabled = false
        self.orderView?.qrCodeTableID = qrCodeTableID
        self.orderView?.qrCodeRestaurantID = qrCodeRestaurantID
        self.orderView?.menuItemId = menuItemId
        UIApplication.getTopViewController()?.view.addSubview(self.alphaView!)
        UIView.animate(withDuration: 0.7, animations: {
            self.orderView!.frame.origin.x = 20
        }) { (finished) in
            
        }
    }
    
    @objc func dissMissOrderMenu() {
        if (self.orderView != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                self.alphaView?.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.7, animations: {
                self.orderView!.frame.origin.x = (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1
                
            }) { (finished) in
                
            }
        }
    }
}

extension MenuViewController : ExpyTableViewDelegate,ExpyTableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuSubTableViewCell.identifier, for: indexPath) as! MenuSubTableViewCell
        cell.configuration(model: (self.menuItemResponseModel?.categoryItems?[indexPath.section].menuItems?[indexPath.row - 1])!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.menuItemResponseModel?.categoryItems!.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.menuItemResponseModel?.categoryItems![section].menuItems?.count)! + 1
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        // This cell will be displayed at IndexPath with (section: section and row: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier) as! MenuTableViewCell
        cell.configuration(model: (self.menuItemResponseModel?.categoryItems?[section])!)
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
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
        if indexPath.row != 0 {
            let model =  (self.menuItemResponseModel?.categoryItems?[indexPath.section].menuItems?[indexPath.row - 1])!
            let putAddMenuItemModel = PutMenuItemRequestModel.init(menuItemId: model.id!, quantity:1, offerNote: "")
                   NetworkManager.sendHeaderAndBodyRequest(url: Constants.BASE_SERVICE_URL, endPoint: .PutMenuItem, method: .post, headerKeys: ["QRCodeRestaurantId","QRCodeTableId"], headerValues: [String(self.qrCodeRestaurantID),String(self.qrCodeTableID)], requestJsonModel: putAddMenuItemModel) { (response : BaseResponse<MenuItemResponseModel>) in
                       if response.statu ?? false {
                            self.showOrderMenu(name: model.itemName ?? "", count: "1", price: (model.price ?? 0),menuItemId : model.id!)
                       }
                   }
        }
    }
    
}
