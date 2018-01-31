//
//  BaseTableViewCell.swift
//  PoeCraftingSimulator
//
//  Created by Markus Hyvärinen on 13/12/2017.
//  Copyright © 2017 Markus. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    @IBOutlet weak var BaseItemName: UILabel!
    @IBOutlet weak var BaseImage: UIImageView!
    @IBOutlet weak var RowOne: UILabel!
    
    @IBOutlet weak var RowTwo: UILabel!
    
    @IBOutlet weak var BaseStrReq: UILabel!
    @IBOutlet weak var BaseDexReq: UILabel!
    @IBOutlet weak var BaseIntReq: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
