//
//  BaseHeaderView.swift
//  Sos
//
//  Created by Akif Demirezen on 23.08.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

@IBDesignable
public class BaseHeaderViewCircle: UIView {
  
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnLeftMenu: UIButton!
    
    var leftMenuView : LeftMenuView?
    var alphaView : UIView?
    
    
    @IBOutlet weak var btnBasket: UIButton!
    @IBOutlet weak var btnCallService: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var labelAskService: UILabel!
    @IBOutlet weak var labelBasket: UILabel!
    @IBOutlet weak var labelLogout: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnLeftMenu.addTarget(self, action: #selector(showLeftMenu), for: .touchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupThisView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThisView()
    }
    
    @IBAction func btnPressedLogout(_ sender: Any) {
        Defaults().clearData()
        UIApplication.getTopViewController()?.navigationController?.popToRootViewController(animated: true)
    }
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        addSubview(view)
        contentView = view
    }
    
    @objc func showLeftMenu(){
       self.alphaView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (((UIApplication.getTopViewController()?.view.frame.size.width)!)), height: ((UIApplication.getTopViewController()?.view.frame.size.height)!)))
       self.alphaView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
       self.leftMenuView = LeftMenuView.init(frame: CGRect.init(x: (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1, y: 0, width: (((UIApplication.getTopViewController()?.view.frame.size.width)!)), height: ((UIApplication.getTopViewController()?.view.frame.size.height)!)))
        self.leftMenuView?.btnDismiss.addTarget(self, action: #selector(dissMissLeftMenuVoid), for: .touchDown)
        self.leftMenuView?.btnDismissView.addTarget(self, action: #selector(dissMissLeftMenuVoid), for: .touchDown)
        self.leftMenuView?.delegate = self
        UIApplication.getTopViewController()?.view.addSubview(self.alphaView!)
        UIApplication.getTopViewController()?.view.addSubview(self.leftMenuView!)
        UIView.animate(withDuration: 0.7, animations: {
            self.leftMenuView!.frame.origin.x = 0
         
        }) { (finished) in
        }
    }
    
    @IBAction func btnPressedLogin(_ sender: Any) {
        
    }
    @objc func dissMissLeftMenu(ended: @escaping () -> Void){
        if (self.leftMenuView != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                self.alphaView?.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.7, animations: {
                self.leftMenuView!.frame.origin.x = (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1
                
            }) { (finished) in
                self.leftMenuView?.removeFromSuperview()
                ended()
            }
        }
    }
    
    @objc func dissMissLeftMenuVoid(){
        if (self.leftMenuView != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                self.alphaView?.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.7, animations: {
                self.leftMenuView!.frame.origin.x = (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1
                
            }) { (finished) in
                self.leftMenuView?.removeFromSuperview()
            }
        }
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: BaseHeaderViewCircle.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
}
extension BaseHeaderViewCircle : LeftMenuSelectionDelegate{
    func removeLeftMenuView(vcType: Int) {
        self.dissMissLeftMenu() {
            print("Akif")
            if vcType == 0 {
                if Defaults().getMenuState() == "2"{
                    //Show qr code
                    let vc = UIApplication.getTopViewController()?.sosReturnViewController(type: .MainViewController) as! MainViewController
                    vc.showReadQrCode()
                }
            }
            else if vcType == 1{
                
            }
            else if vcType == 2{
                
            }
            else if vcType == 3{
                
            }
            else if vcType == 4{
                let vc = UIApplication.getTopViewController()?.sosReturnViewController(type: .AboutUsViewController) as! AboutUsViewController
                UIApplication.getTopViewController()?.sosPushViewController(viewController: vc)
            }
            else if vcType == 5{
                let vc = UIApplication.getTopViewController()?.sosReturnViewController(type: .ConnectionViewController) as! ConnectionViewController
                UIApplication.getTopViewController()?.sosPushViewController(viewController: vc)
            }
            else if vcType == 6{
                Defaults().clearData()
                UIApplication.getTopViewController()?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
