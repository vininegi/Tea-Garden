//
//  ForgotViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 28/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class ForgotViewController: BaseViewController {
    
    @IBOutlet weak var forgotLoginButton: UIButton!
    
    @IBOutlet weak var forgotPassButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let btn = sender as! UIButton
       /* if isChecked
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
               isChecked = !isChecked */
        

        
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
       /* self.activity?.startAnimating()
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
              })*/
        
    }
}
