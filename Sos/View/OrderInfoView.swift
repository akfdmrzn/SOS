//
//  OrderInfoView.swift
//  Sos
//
//  Created by Akif Demirezen on 12.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

@IBDesignable
public class OrderInfoView: UIView {
    
    @IBOutlet weak var btnDissmissView: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var btnMakeOrder: UIButton!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightTextviewConstraint: NSLayoutConstraint!
    
    var name : String?
    var price : String?
    var count : String?
    
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
    
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        contentView.layer.cornerRadius = 7.0
        contentView.layer.masksToBounds = true
        
        self.btnMakeOrder.layer.cornerRadius = 7.0
        self.btnMakeOrder.layer.masksToBounds = true
        
        self.btnAddProduct.layer.cornerRadius = 7.0
        self.btnMakeOrder.layer.masksToBounds = true
        
        
        self.tableView.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 70
        self.tableView.reloadData()
    }
    
    @IBAction func btnPressedShowTextView(_ sender: Any) {
        if self.heightTextviewConstraint.constant == 0{
            self.heightTextviewConstraint.constant = 150
        }
        else{
            self.heightTextviewConstraint.constant = 0

        }
        UIView.animate(withDuration: 0.6, animations: {
            self.contentView.layoutIfNeeded()
        })
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: OrderInfoView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
    @IBAction func btnAddProductPressed(_ sender: Any) {
    }
    
    @IBAction func btnMakeOrderPressed(_ sender: Any) {
    }
    
}
extension OrderInfoView : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as! MenuItemTableViewCell
        cell.setConfigurationModel(name: self.name ?? "", price: self.price ?? "", count: self.count ?? "1",alwaysPrice: Int(self.price!)!)
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
