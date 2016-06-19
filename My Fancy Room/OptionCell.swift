//
//  OptionCell.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var quantityTF: UITextField!
    var quantity:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        self.customImageView?.image = nil
        self.titleLabel?.text = ""
        self.descriptionLabel?.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeQuantity(sender: AnyObject) {
        
        if self.quantity < 10 {
            self.quantity += 1
        }
        
        
        self.quantityTF.text = "\(self.quantity)"
    }
    
    

}
