//
//  MenuTableViewCell.swift
//  Sos
//
//  Created by Akif Demirezen on 11.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import SDWebImage

class MenuTableViewCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        self.imageViewBackground.layer.cornerRadius = 7.0
        self.imageViewBackground.layer.masksToBounds = true
        
        self.viewBackground.layer.cornerRadius = 7.0
        self.viewBackground.layer.masksToBounds = true
        
    }

    func configuration(model : CategoryItems)  {
        self.labelCategory.text = model.categoryName
        self.imageViewBackground.sd_setImage(with: URL.init(string: model.categoryImageUrl ?? ""), completed: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
