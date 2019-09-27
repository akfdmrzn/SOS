//
//  AlertView.swift
//  Sos
//
//  Created by Akif Demirezen on 16.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var containerView: UIView!
    
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
        
        self.containerView.layer.cornerRadius = 7.0
        self.containerView.layer.masksToBounds = true
        
        self.btnCancel.layer.cornerRadius = 7.0
        self.btnCancel.layer.masksToBounds = true
        
        self.btnConfirm.layer.cornerRadius = 7.0
        self.btnConfirm.layer.masksToBounds = true
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: AlertView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    @IBAction func btnPressedCancel(_ sender: Any) {
        let baseVC = UIApplication.getTopViewController() as! BaseViewController
        baseVC.dismissAlertView()
    }
    
    @IBAction func btnPressedOkay(_ sender: Any) {
        UIApplication.getTopViewController()?.navigationController?.popViewController(animated: true)
    }
}
