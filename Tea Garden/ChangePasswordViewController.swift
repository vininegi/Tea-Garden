//
//  ChangePasswordViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 25/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePasswordViewController: BaseViewController {
    @IBOutlet weak var otpTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passTexfield: SkyFloatingLabelTextField!
    @IBOutlet weak var oldPassTextField: SkyFloatingLabelTextField!
    var isReset:Bool = false
    var userName:String?
    var otp:String?
    @IBOutlet weak var resendButton: CustomButton!
    
    
    @IBOutlet weak var confirmPassTextField: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isReset
        {
            oldPassTextField.isHidden = true
        }
        else
        {
            otpTextField.isHidden = true
            resendButton.isHidden = true
            //confirmPassTextField.isHidden = true
        }
        
        registerScrollView(scrollView: scrollView)
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if !isReset && !oldPassTextField.hasText
        {
            showAlert(title:"Required", message:"Please enter old password")
            return
        }
        if isReset && !otpTextField.hasText
        {
            showAlert(title:"Required", message:"Please enter OTP")
            return
        }
        else if !passTexfield.hasText
        {
            showAlert(title:"Required", message:"Please enter new password")
            return
        }
        else if isReset && !confirmPassTextField.hasText
        {
            showAlert(title:"Required", message:"Please enter confirm password")
            return
        }
        else if passTexfield.text ?? "" != confirmPassTextField.text ?? ""
        {
          showAlert(title:"Required", message:"Password and confirm password didn't match")
          return
        }
        self.activity?.startAnimating()
        if !isConnectedToInternet()
        {
            self.activity?.stopAnimating()
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        
        var url = API.CHANGE_PASSWORD
        var dic = ["password":passTexfield.text ?? ""] as! [String:Any]
        if isReset
        {
            url = API.RESET_PASSWORD
            dic["username"] = userName ?? ""
            dic["otp"] = Int(otpTextField.text ?? "0")
            dic["confirm_password"] = confirmPassTextField.text ?? ""
            
        }
        else
        {
            dic["username"] = SavedData.UserName ?? ""
            dic["oldPassword"] = oldPassTextField.text ?? ""
        }
        print(dic)
        let headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        
        _ = WebService(action: url, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            //handle and show garden list
            self.activity?.stopAnimating()
            
            if let data = response?.dictionaryObject
            {
                if data["status"] as? Bool ?? false == true{
                    
                    self.navigationController?.popViewController(animated: false)
                    showAlert(title: nil , message: data["message"] as? String ?? "")
                }
            }
        })
        
    }
    
    
    
    @IBAction func resendTapped(_ sender: CustomButton) {
        
       if !isConnectedToInternet()
        {
            self.activity?.stopAnimating()
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        self.activity?.startAnimating()
        let dic = ["username":userName ?? ""]
        
        _ = WebService(action: API.FORGOT_PASSWORD_URL, postMethod: .post, parameters: dic, headers: nil, success: { (response, error) in
            self.activity?.stopAnimating()
            //handle
            if let value = response?.dictionaryObject
            {
                if value["status"] as? Bool ?? false == true{
                    
                    //Show alert for successfully sent on reset password
                    showAlert(title:nil, message:value["message"] as? String ?? "")
                }
                else
                {
                    showAlert(title: "", message: "Something went wrong")
                    return
                }
            }
            
            
        })
        
    }
    
    
    
}
