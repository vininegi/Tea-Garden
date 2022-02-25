//
//  SheetTableViewCell.swift
//  Tea Garden
//
//  Created by Vandana Negi on 14/03/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class SheetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
