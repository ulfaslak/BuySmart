//
//  ShoppingTableViewCell.swift
//  BuySmart
//
//  Created by Ulf Aslak Jensen on 17/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
