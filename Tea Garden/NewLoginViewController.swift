//
//  NewLoginViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 01/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import NVActivityIndicatorView


class NewLoginViewController: BaseViewController {
    
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var userName: SkyFloatingLabelTextField!
    @IBOutlet weak var checkButton: UIButton!
    var isChecked:Bool = false
    var loginData:LoginModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerScrollView(scrollView: scrollView)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    @IBAction func termsDetailButtonTapped(_ sender: Any) {
        //open a url
        if isConnectedToInternet()
        {
            self.activity?.startAnimating()
            if let url = URL(string: "https://zovini.com/terms-and-conditions") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else{
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        self.activity?.stopAnimating()
    }
    
    
    
    @IBAction func termsButtonTapped(_ sender: Any) {
        
        if isChecked
        {
            self.checkButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.checkButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
                self.checkButton.transform = .identity
            }, completion: nil)
        }
        else{
            self.checkButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.checkButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
                self.checkButton.transform = .identity
            }, completion: nil)
        }
        isChecked = !isChecked
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        if !userName.hasText
        {
            showAlert(title:"Error", message: "Please enter username")
            return
        }
        else if !password.hasText
        {
            showAlert(title:"Error", message: "Please enter a password")
            return
        }
        else if !isChecked
        {
            //showAlert(title:"Error", message: "Please check terms and conditions")
            //return
        }
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        
        self.activity?.startAnimating()
        let dic = ["username":userName.text!,"userpassword":password.text!]
        print(dic)
        _ = WebService(action: API.LOGIN_URL, postMethod: .post, parameters: dic as [String : Any], headers: nil, success: { (response, error) in
            //handle
            self.activity?.stopAnimating()
            if let value = response?.dictionaryObject
            {
                if value["status"] as? Bool ?? false == true{
                    SavedData.isLoggedIn = true
                    self.loginData = LoginModel(dic: value["data"] as! [String:Any])
                    appDelegate().openDashboardView()
                }
                else
                {
                    showAlert(title: "", message: "Invalid login details")
                    return
                }
            }
        })
        
    }
    
    @IBAction func forgotButtonTapped(_ sender: Any) {
        
        if !userName.hasText
        {
            showAlert(title:"Error", message: "Please enter username")
            return
        }
        if !isConnectedToInternet()
        {
            self.activity?.stopAnimating()
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        self.activity?.startAnimating()
        let dic = ["username":userName.text ?? ""]
        
        _ = WebService(action: API.FORGOT_PASSWORD_URL, postMethod: .post, parameters: dic, headers: nil, success: { (response, error) in
            self.activity?.stopAnimating()
            //handle
            print(response)
            if let value = response?.dictionaryObject
            {
                if value["status"] as? Bool ?? false == true{
                    
                    //open change password page
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
                    vc.isReset = true
                    vc.userName = self.userName.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                    //Show alert for successfully sent on reset password
                    showAlert(title:nil, message:value["message"] as? String ?? "")
                }
                else
                {
                    if let error = value["errors"] as? [String:Any]
                    {
                        showAlert(title:nil, message:(error["username"] as? String ?? "").uppercased())
                        return
                    }
                    
                }
            }
            
            
        })
        
    }
    
    
    @IBAction func openSignUpView(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let vc = self.storyboard?.instantiateViewController(withIdentifier:"SubscriptionPopUpViewController") as! SubscriptionPopUpViewController
         vc.modalPresentationStyle = .custom
                 self.present(vc, animated: false, completion: nil)
       /* let vc = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseViewController") as! PurchaseViewController
       vc.isSignUp = true
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
    
    
    
}
