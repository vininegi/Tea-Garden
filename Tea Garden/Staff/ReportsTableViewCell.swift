//
//  ReportsTableViewCell.swift
//  Tea Garden
//
//  Created by Vandana Negi on 14/03/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var daysTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
