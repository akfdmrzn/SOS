//
//  MyOrdersSubTableViewCell.swift
//  Sos
//
//  Created by Akif Demirezen on 5.10.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class MyOrdersSubTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageViewDetail: UIImageView!
    
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
    
    func setConfiguration(title : String,desc : String){
        self.labelTitle.text = title
        self.labelDesc.text = desc
    }
    
}
