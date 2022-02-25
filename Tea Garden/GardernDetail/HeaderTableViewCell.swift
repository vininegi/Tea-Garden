//
//  HeaderTableViewCell.swift
//  Tea Garden
//
//  Created by Vandana Negi on 25/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
