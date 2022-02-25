//
//  StaffListTableViewCell.swift
//  Tea Garden
//
//  Created by Vandana Negi on 21/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class StaffListTableViewCell: UITableViewCell {

    @IBOutlet weak var accessButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
