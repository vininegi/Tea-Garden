//
//  CustomButton.swift
//  Tea Garden
//
//  Created by Vandana Negi on 01/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setProperty()
    }
    
    
    func setProperty()
    {
      self.layer.cornerRadius = 6
      self.clipsToBounds = true
    }
    
}
