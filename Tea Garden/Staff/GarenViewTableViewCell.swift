//
//  GarenViewTableViewCell.swift
//  Tea Garden
//
//  Created by Vandana Negi on 22/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class GarenViewTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
