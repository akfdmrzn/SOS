//
//  MenıSubTableViewCell.swift
//  Sos
//
//  Created by Akif Demirezen on 11.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class MenuSubTableViewCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var labelMenu: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func configuration(model : MenuItems){
        self.labelMenu.text = model.itemName ?? ""
        self.labelDesc.text = model.itemIngredients ?? ""
        self.labelPrice.text = "\(model.price ?? 0) TL"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
