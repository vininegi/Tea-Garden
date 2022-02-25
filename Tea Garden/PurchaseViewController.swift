//
//  PurchaseViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 03/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PurchaseViewController: BaseViewController {

    var isSignUp:Bool = false
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var gstTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var mobile: SkyFloatingLabelTextField!
    @IBOutlet weak var addressName: SkyFloatingLabelTextField!
    @IBOutlet weak var garderName: SkyFloatingLabelTextField!
    @IBOutlet weak var keyPersonName: SkyFloatingLabelTextField!
    @IBOutlet weak var groupName: SkyFloatingLabelTextField!
    @IBOutlet weak var companyName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userName: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    var loginData:LoginModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var referenceTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var pincodetextfield: SkyFloatingLabelTextField!
    @IBOutlet weak var panNoTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var citytextField: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         registerScrollView(scrollView: scrollView)
      self.navigationController?.navigationBar.isHidden = false
        
        if isSignUp
        {
            subscribeLabel.isHidden = true
            panNoTextField.isHidden = true
        }
    }
    

 
    @IBAction func submitButtonClicked(_ sender: Any) {
       
       
        if !groupName.hasText
        {
            showAlert(title:"Error", message: "Please enter a group name")
            return
        }
        else if !garderName.hasText
        {
            showAlert(title:"Error", message: "Please enter garden name")
            return
        }
        else if !userName.hasText
        {
            showAlert(title:"Error", message: "Please enter a username")
            return
        }
        else if !passwordTextField.hasText
        {
            showAlert(title:"Error", message: "Please enter a password")
            return
        }
        else if !confirmPassword.hasText
        {
            showAlert(title:"Error", message: "Please enter repeat password")
            return
        }
        else if !companyName.hasText
        {
            showAlert(title:"Error", message: "Please enter company name")
            return
        }
        else if !keyPersonName.hasText
        {
            showAlert(title:"Error", message: "Please enter key person name")
            return
        }
        else if !addressName.hasText
        {
            showAlert(title:"Error", message: "Please enter address")
            return
        }
        else if !mobile.hasText
        {
            showAlert(title:"Error", message: "Please enter mobile number")
            return
        }
        else if !email.hasText
        {
            showAlert(title:"Error", message: "Please enter email")
            return
        }
        else if !isValidEmail(testStr: email.text ?? "")
        {
            showAlert(title:"Error", message: "Please enter valid email")
            return
        }
        
        if !isConnectedToInternet()
             {
                //self.activity?.stopAnimating()
             showAlert(title: "No Internet Connection", message:"Please check your internet connection")
             return
             }
         self.activity?.startAnimating()
        var dic = ["username":userName.text ?? "","name":groupName.text ?? "","garden_name":garderName.text ?? "","password":passwordTextField.text ?? "","confirm_password":confirmPassword.text ?? "","address":addressName.text ?? "","gst_no":gstTextField.text ?? "","key_person_name":keyPersonName.text ?? ""] as [String : Any]
        
        if isSignUp
        {
            dic["pan_no"] = panNoTextField.text ?? ""
        }
        
        
        _ = WebService(action: API.REGISTRATION_URL, postMethod: .post, parameters: dic, headers: nil, success: { (response, error) in
            //handle
             self.activity?.stopAnimating()
            print(response)
            if let value = response?.dictionaryObject
            {
                if let status = value["status"] as? Bool, status == false
                {
                   showAlert(title: "", message: "Something went wrong")
                   return
                }
                else
                {
                SavedData.isLoggedIn = true
                self.loginData = LoginModel(dic: value["data"] as! [String:Any])
                appDelegate().openDashboardView()
                }
            }
            //Show alert for successfully sent on reset password
            
        })
       
    }
    func textFieldEditingChanged(textField: UITextField) {
        textField.invalidateIntrinsicContentSize()
    }

}



