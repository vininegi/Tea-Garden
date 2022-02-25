//
//  CustomTextField.swift
//  Tea Garden
//
//  Created by Vandana Negi on 17/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField {
   
    @IBInspectable var rightImage:UIImage = UIImage(){
        didSet
        {
          let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
          imageView.image = #imageLiteral(resourceName: "ic_calendar")
          self.rightView = imageView
          self.rightViewMode = .always
        }
    }
   
    var cornerImage:UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setUp()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       setUp()
    }
    
    
    
    func setUp() 
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "ic_calendar")
        self.rightView = imageView
        self.rightViewMode = .always
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
        
    }
    
    
   
    
}
