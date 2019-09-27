//
//  LeftMenuTableViewCell.swift
//  Sos
//
//  Created by Akif Demirezen on 11.09.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(model : LeftMenuCellModel){
        self.imageViewLeft.image = model.image
        self.labelTitle.text = model.value
    }
    
}
public class LeftMenuCellModel{
    var id:Int!
    var value:String!
    var image:UIImage!
    
    init() {}
    
    init(id:Int,value:String,image:UIImage) {
        self.id = id
        self.value = value
        self.image = image
    }
}


