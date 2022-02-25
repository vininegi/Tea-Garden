//
//  SignUpViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 21/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpViewController: BaseViewController {

    @IBOutlet weak var mobileTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var groupNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPassTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var gardenNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tandcButton: UIButton!
    @IBOutlet weak var tandCTextButton: UIButton!
    var isChecked:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerScrollView(scrollView: scrollView)
        self.navigationController?.navigationBar.isHidden = false
    }
    

  
    @IBAction func termsDetailButtonTapped(_ sender: Any) {
        //open a url
       
        self.activity?.startAnimating()
        if !isConnectedToInternet()
                 {
                    self.activity?.stopAnimating()
                 showAlert(title: "No Internet Connection", message:"Please check your internet connection")
                 return
                 }
        if let url = URL(string: "https://zovini.com/terms-and-conditions") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
                
                // Fallback on earlier versions
            }
            
        }
        
      
         self.activity?.stopAnimating()
        
    }
    
    
    
    @IBAction func termsButtonTapped(_ sender: Any) {
        
        if isChecked
        {
            self.tandcButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.tandcButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
                self.tandcButton.transform = .identity
            }, completion: nil)
        }
        else{
            self.tandcButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.tandcButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
                self.tandcButton.transform = .identity
            }, completion: nil)
        }
        isChecked = !isChecked
        
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
       
         
        if !groupNameTextField.hasText
        {
            showAlert(title: "Alert!", message: "Please enter group name")
            return
        }
        else if !gardenNameTextField.hasText
        {
            showAlert(title: "Alert!", message: "Please enter garden name")
            return
        }
        else if !userNameTextField.hasText
        {
            showAlert(title: "Alert!", message: "Please enter user name")
            return
        }
       else if !passwordTextField.hasText
        {
            showAlert(title: "Alert!", message: "Please enter password")
            return
        }
       else if !confirmPassTextField.hasText
        {
            showAlert(title: "Alert!", message: "Please enter confirm password")
            return
        }
        else if !isChecked
        {
            showAlert(title:nil, message: "Please check terms and condition")
            return
        }
        if !isConnectedToInternet()
                 {
                    self.activity?.stopAnimating()
                 showAlert(title: "No Internet Connection", message:"Please check your internet connection")
                 return
                 }
        self.activity?.startAnimating()
        let dic = ["name":userNameTextField.text ?? "","garden_name":gardenNameTextField.text ?? "","username":userNameTextField.text ?? "","password":passwordTextField.text ?? "","confirm_password":confirmPassTextField.text ?? "", "email":emailTextField.text ?? "","mobile":mobileTextField.text ?? ""] as [String : Any]
        print(dic)
        _ = WebService(action: API.REGISTRATION_URL, postMethod: .post, parameters: dic, headers: nil, success: { (response, error) in
            //handle
             self.activity?.stopAnimating()
            if let value = response?.dictionaryObject
            {
            if let status = value["status"] as? Bool, status == false
            {
               showAlert(title: "", message: "Something went wrong")
               return
            }
            else
            {
            appDelegate().openLoginView()
            }
            }
        })
        
     
    }
    

}
