//
//  LoginViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import MessageUI

class LoginViewController: BaseViewController, UITextViewDelegate,MFMailComposeViewControllerDelegate{

    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var mailTextView: UITextView!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var demoButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var phoneNum = "8160068676"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailTextView.textContainerInset = .zero
        phoneTextView.textContainerInset = .zero
        // Do any additional setup after loading the view.
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //MARK:- hides nav bar line
       // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
 
        @IBAction func demoButtonTapped(_ sender: Any) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        @IBAction func purchaseButtonTapped(_ sender: Any) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = self.storyboard?.instantiateViewController(withIdentifier:"SubscriptionPopUpViewController") as! SubscriptionPopUpViewController
            vc.modalPresentationStyle = .custom
                     self.present(vc, animated: false, completion: nil)
            
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PurchaseViewController") as! PurchaseViewController
            self.navigationController?.pushViewController(controller, animated: true)*/
            
        }
    
        
        @IBAction func pdfButtonTapped(_ sender: Any) {
           /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(controller, animated: true)*/
            
        }
        
        @IBAction func signUpButtonTapped(_ sender: Any) {
         
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            /*let vc = self.storyboard?.instantiateViewController(withIdentifier:"SubscriptionPopUpViewController") as! SubscriptionPopUpViewController
            self.present(vc, animated: true, completion: nil)*/
            //TO DO:- removed below code for now, will add on again if needed
           let controller = storyboard.instantiateViewController(withIdentifier: "PurchaseViewController") as! PurchaseViewController
            controller.isSignUp = true
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    
    
        @IBAction func loginButtonTapped(_ sender: Any) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController") as! NewLoginViewController
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
               return false
           }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          dismiss(animated: true, completion: nil)
    }

}
