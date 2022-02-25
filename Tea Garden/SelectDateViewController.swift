//
//  SelectDateViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 17/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class SelectDateViewController:BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    
    var datePicker:UIDatePicker!
    var selectedTextField:UITextField!
    var onTap:((String?,String?)->Void)?
    
    var isSingle:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        registerScrollView(scrollView: scrollView)
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        var toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDate))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = .white
        toolBar.items = [flexibleSpace,doneButton]
        startDateTextField.inputAccessoryView = toolBar
        endDateTextField.inputAccessoryView = toolBar
        startDateTextField.rightViewMode = .always
        endDateTextField.rightViewMode = .always
        startDateTextField.rightView = UIImageView(image: #imageLiteral(resourceName: "ic_calendar"))
        endDateTextField.rightView = UIImageView(image: #imageLiteral(resourceName: "ic_calendar"))
        datePicker.maximumDate = NSDate() as Date
        
        if isSingle
        {
            endDateTextField.isHidden = true
            startDateTextField.placeholder = "Select Date"
        }
        
    }
    

    
    @objc func backButtonTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
      if !startDateTextField.hasText
      {
        showAlert(title: "Alert!", message: "Please select start date")
        return
      }
     else if !isSingle && !endDateTextField.hasText
      {
        showAlert(title: "Alert!", message: "Please select end date")
        return
      }
        if !isSingle && startDateTextField.text! > endDateTextField.text!
        {
            showAlert(title: "Alert!", message: "Start date cannot be greater than end date")
                   return
        }
        if !isSingle && startDateTextField.text! > endDateTextField.text!
               {
                   showAlert(title: "Alert!", message: "Start date cannot be greater than end date")
                          return
               }
        if isSingle
        {
            self.onTap?(self.startDateTextField.text!,nil)
            self.navigationController?.popViewController(animated: false)
            return
        }
         self.onTap?(self.startDateTextField.text!,self.endDateTextField.text!)
        self.navigationController?.popViewController(animated: false)
     /* self.dismiss(animated: true) {
        self.onTap?(self.startDateTextField.text!,self.endDateTextField.text!)
      }*/
        
        
    }
    
    
    @objc func setDate()
    {
        selectedTextField.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: nil)
        selectedTextField.resignFirstResponder()
        //self.view.endEditing(true)
    }
    
    @objc func dateChanged()
       {
        selectedTextField.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: nil)
           //selectedTextField.resignFirstResponder()
           //self.view.endEditing(true)
       }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           selectedTextField = textField
        textField.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: nil)
       }
    
    
    
}


 

