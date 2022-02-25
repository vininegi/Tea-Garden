//
//  ContentView.swift
//  Tea Garden
//
//  Created by Vandana Negi on 22/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class ContentView: UIView {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setFrame()
            setShadow()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setFrame()
            setShadow()
        }
        
        func setFrame()
        {
            self.backgroundColor = UIColor.lightGray
            
            //self.clipsToBounds = true
        }
        
        func setShadow()
        {
            self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
            self.layer.shadowOffset = .zero
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.7
            self.layer.masksToBounds = false
        }
    
}
