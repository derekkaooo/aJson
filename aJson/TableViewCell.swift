//
//  TableViewCell.swift
//  aJson
//
//  Created by Derek on 2018/8/26.
//  Copyright © 2018年 Derek. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var typesLbl: UILabel!
    
    @IBOutlet weak var hpLbl: UILabel!
    
    @IBOutlet weak var subtypeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
