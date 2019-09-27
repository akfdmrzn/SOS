//
//  BaseBackHeaderView.swift
//  Sos
//
//  Created by Akif Demirezen on 10.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//
import UIKit

@IBDesignable
public class BaseBackHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnLeftMenu: UIButton!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    var leftMenuView : LeftMenuView?
    var alphaView : UIView?
    
    @IBInspectable var isTransBackground: Bool = false {
        didSet {
            self.contentView.backgroundColor = UIColor.init(red: 233.0/255.0, green: 98.0/255.0, blue: 48.0/255.0, alpha: 0.7)
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnLeftMenu.addTarget(self, action: #selector(returnBackPage), for: .touchDown)
        
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
        
    }
    
    @objc func returnBackPage(){
        UIApplication.getTopViewController()?.navigationController?.popViewController(animated: true)
    }
    
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: BaseBackHeaderView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
}
