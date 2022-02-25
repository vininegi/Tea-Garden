//
//  SelectDaysViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class SelectDaysViewController: BaseViewController {
    
 var onTap:((String?)->Void)?
    
    @IBOutlet weak var daysTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

       registerScrollView(scrollView: scrollView)
     
        
        
    }
    
    
    @objc func backButtonTapped()
       {
           self.dismiss(animated: true, completion: nil)
       }
       
       
    @IBAction func nextTapped(_ sender: Any) {
        
        if !daysTextField.hasText
             {
               showAlert(title: "Alert!", message: "Please select start date")
               return
             }
        self.onTap?(self.daysTextField.text!)
        self.navigationController?.popViewController(animated: false)
             /*self.dismiss(animated: true) {
               self.onTap?(self.daysTextField.text!)
             }*/
    }
    
}
