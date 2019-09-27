//
//  LeftMenuView.swift
//  Sos
//
//  Created by Akif Demirezen on 23.08.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

protocol LeftMenuSelectionDelegate {
    func removeLeftMenuView(vcType:Int)
}

@IBDesignable
public class LeftMenuView: UIView {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var btnDismissView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var delegate : LeftMenuSelectionDelegate?
    
    var menuList : [LeftMenuCellModel] = []
    var loginMenuList : [LeftMenuCellModel] = [
        LeftMenuCellModel.init(id: 0, value: "Menü", image: UIImage.init(named: "menu")!),
        LeftMenuCellModel.init(id: 1, value: "Siparişlerim", image: UIImage.init(named: "food")!),
        LeftMenuCellModel.init(id: 2, value: "Ne Kadar Şanslıyım", image: UIImage.init(named: "doughnut-1")!),
        LeftMenuCellModel.init(id: 3, value: "Kredilerim", image: UIImage.init(named: "candy-1")!),
        LeftMenuCellModel.init(id: 4, value: "Hakkımızda", image: UIImage.init(named: "information-2")!),
        LeftMenuCellModel.init(id: 5, value: "İletişim", image: UIImage.init(named: "phone-2")!),
        LeftMenuCellModel.init(id: 6, value: "Güvenli Çıkış", image: UIImage.init(named: "Shape-2")!)
    ]
    var notLoginMenuList : [LeftMenuCellModel] = [
        LeftMenuCellModel.init(id: 7, value: "QR Kod Okut", image: UIImage.init(named: "QR-Code")!),
        LeftMenuCellModel.init(id: 1, value: "Siparişlerim", image: UIImage.init(named: "food")!),
        LeftMenuCellModel.init(id: 2, value: "Ne Kadar Şanslıyım", image: UIImage.init(named: "doughnut-1")!),
        LeftMenuCellModel.init(id: 3, value: "Kredilerim", image: UIImage.init(named: "candy-1")!),
        LeftMenuCellModel.init(id: 4, value: "Hakkımızda", image: UIImage.init(named: "information-2")!),
        LeftMenuCellModel.init(id: 5, value: "İletişim", image: UIImage.init(named: "phone-2")!),
        LeftMenuCellModel.init(id: 6, value: "Güvenli Çıkış", image: UIImage.init(named: "Shape-2")!)
    ]
    
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
    
    @IBAction func btnPressedDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func btnPressedProfile(_ sender: Any) {
        if Defaults().getLoginState() == "1" {
            
            self.delegate?.removeLeftMenuView(vcType: 0)
            let vc = UIApplication.getTopViewController()?.sosReturnViewController(type: .ProfileViewController) as! ProfileViewController
            UIApplication.getTopViewController()?.sosPushViewController(viewController: vc)
        }
        
    }
    
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
        self.tableView.register(LeftMenuTableViewCell.nib, forCellReuseIdentifier: LeftMenuTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        self.labelName.text = Defaults().getName()
        
        if Defaults().getMenuState() == "1" {
            self.menuList = self.loginMenuList
        }
        else{
            self.menuList = self.notLoginMenuList
        }
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: LeftMenuView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
}
extension LeftMenuView : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTableViewCell.identifier, for: indexPath) as! LeftMenuTableViewCell
        cell.configure(model: self.menuList[indexPath.row])
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.removeLeftMenuView(vcType: indexPath.row)
    }
}
