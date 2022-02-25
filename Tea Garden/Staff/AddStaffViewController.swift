//
//  AddStaffViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 24/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddStaffViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var userName: SkyFloatingLabelTextField!
    @IBOutlet weak var employeeFullName: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var mobile: SkyFloatingLabelTextField!
    
    @IBOutlet weak var submitButton: CustomButton!
    @IBOutlet weak var dateOfBirth: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    var datePicker:UIDatePicker!
    var empID:Int?
    var employeeDetail:StaffModel?
    var groupID:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        var toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setDate))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = .white
        toolBar.items = [flexibleSpace,doneButton]
        dateOfBirth.inputAccessoryView = toolBar
        dateOfBirth.inputView = datePicker
        
        registerScrollView(scrollView: scrollView)
        setData()
    }
    
    
    //MARK:- set data before displaying
    func setData()
    {
        if let data = employeeDetail
        {
            employeeFullName.text = data.name ?? ""
            userName.text = data.username ?? ""
            mobile.text = data.mobile ?? ""
            email.text = data.email ?? ""
            dateOfBirth.text = data.dob ?? ""
            //password.text = data.password ?? ""
            //password.isSecureTextEntry = false
            submitButton.setTitle("UPDATE", for: .normal)
            confirmPassword.isHidden = true
        }
    }
    
    
    
    
    
    @objc func setDate()
    {
        dateOfBirth.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: NEW_DATE_FORMAT)
        dateOfBirth.resignFirstResponder()
        //self.view.endEditing(true)
    }
    
    
    @objc func dateChanged()
    {
        dateOfBirth.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: NEW_DATE_FORMAT)
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateOfBirth
        {
            textField.text = convertTodayDateToString(date: datePicker!.date as NSDate, inputStringFormat: NEW_DATE_FORMAT)
        }
        if textField == password
        {
            textField.isSecureTextEntry = true
        }
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if !employeeFullName.hasText
        {
            showAlert(title:"Error", message: "Please enter employee's full name")
            return
        }
        else if !userName.hasText
        {
            showAlert(title:"Error", message: "Please enter username")
            return
        }
            
        else if !password.hasText
        {
            showAlert(title:"Error", message: "Please enter a password")
            return
        }
            
        else if employeeDetail == nil && !confirmPassword.hasText
        {
            showAlert(title:"Error", message: "Please enter repeat password")
            return
        }
        else if !dateOfBirth.hasText
        {
            showAlert(title:"Error", message: "Please enter date of joining")
            return
        }
        
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        self.activity?.startAnimating()
        let headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        var dic = ["dob":dateOfBirth.text ?? ""/*,"email":email.text ?? "" , "mobile":mobile.text ?? ""*/,"name":employeeFullName.text ?? "","password":password.text ?? "","username":userName.text ?? "","gardenId":groupID ?? ""] as! [String:Any]
        if let _data = employeeDetail
        {
            dic["id"] = _data.id ?? 0
        }
        if !confirmPassword.hasText
        {
         dic["confirm_password"] = password.text ?? ""
        }
        else
        {
           dic["confirm_password"] = confirmPassword.text ?? ""
        }
        
       print(dic)
        
        print(API.SAVE_EMPLOYEE_DATA)
        _ = WebService(action: API.SAVE_EMPLOYEE_DATA, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            self.activity?.stopAnimating()
            
            if let data = response?.dictionaryObject
            {
                if data["status"] as? Bool ?? false == true{
                    var message = "Added Employee detail successfully"
                    if let _data = self.employeeDetail
                    {
                        message = "Updated employee detail successfully"
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                    showAlert(title:"", message:message)
                    return
                }
                else{
                    if let error = data["errors"] as? [Any]
                    {
                        if error.count > 0
                        {
                            if let value = error[0] as? [String:Any]
                            {
                                let error = value["message"] as? String ?? ""
                                let msg =  value["path"] as? String ?? ""
                                showAlert(title:msg, message:error)
                                return
                            }
                        }
                    }
                    
                }
            }
            
            print(response)
        })
        
        
    }
    
    
    
    
    
}


