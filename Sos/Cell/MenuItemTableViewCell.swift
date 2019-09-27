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
    
    var alwaysPrice : Int = 0
    
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
    @IBAction func btnPressedDecrease(_ sender: Any) {
        if Int(self.labelCount.text!)! == 1 {
            return
        }
        self.labelCount.text = String(Int(self.labelCount.text!)! - 1)
        self.labelPrice.text = String(self.alwaysPrice * (Int(self.labelCount.text!)!))
    }
    @IBAction func btnPressedIncrease(_ sender: Any) {
        self.labelCount.text = String(Int(self.labelCount.text!)! + 1)
        self.labelPrice.text = String(self.alwaysPrice * (Int(self.labelCount.text!)!))
    }
    
    
    func setConfigurationModel(name:String,price : String,count : String,alwaysPrice : Int) {
        self.labelName.text = name
        self.labelPrice.text = price
        self.labelCount.text = count
        self.alwaysPrice = alwaysPrice
    }
    
}
