//
//  OptionCell.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit

@objc protocol orderDelegate{
    
    func orderEdit(item:String, quantity:Int)
}

class OptionCell: UITableViewCell {

    
    weak var delegate:orderDelegate!
    
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
    
    @IBAction func changeQuantity(sender: UIStepper) {
        
        
        
        
            self.quantity =  Int(sender.value)
        
        
        self.quantityTF.text = "\(self.quantity)"
        
        if self.delegate != nil{
            
            self.delegate.orderEdit(self.titleLabel.text!, quantity: self.quantity)
        }
    }
    
    

}
