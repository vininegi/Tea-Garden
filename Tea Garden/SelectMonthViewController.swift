//
//  SelectMonthViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 25/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class SelectMonthViewController: UIViewController {

    var onTap:((Int?)->Void)?
    @IBOutlet weak var pickerView: UIPickerView!
    
    var months = ["January","February","March","April","May","June","July","August","September","October","Novermber","December"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.reloadAllComponents()
        
    }
   
    
    @objc func backButtonTapped()
       {
           self.dismiss(animated: true, completion: nil)
       }
       
       
    @IBAction func submitButtonTapped(_ sender: Any) {
        
       if let data = pickerView.selectedRow(inComponent: 0) as? Int
       {
       self.onTap?(data + 01)
        self.navigationController?.popViewController(animated: false)
       /* self.dismiss(animated: true) {
            self.onTap?(data + 01)
        }*/
        }
        
    }
    
    
    
}


//MARK:- pickerview delegate
extension SelectMonthViewController:UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //select picker view item
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
  
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: months[row])
    }
    
    
}
