//
//  CominSoonPopUpViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/02/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class CominSoonPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapped(gesture:)) )
        self.view.addGestureRecognizer(tapGesture)
        
    }
    

    
    @objc func tapped(gesture:UITapGestureRecognizer)
    {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
