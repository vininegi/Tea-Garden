//
//  BaseViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 30/11/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController{

    var activity:NVActivityIndicatorView?
     private var mScrollView : UIScrollView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        activity = NVActivityIndicatorView(frame: CGRect(x: (self.view.bounds.width/2) - 25, y: (self.view.bounds.height/2) - 25, width: 50, height: 50), type: .ballSpinFadeLoader, color:COLOR_ORANGE, padding: 2)
        self.view.addSubview(activity!)
    }
    
    func registerScrollView(scrollView : UIScrollView) {
           mScrollView = scrollView
       }
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }*/
    
  
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            // Add observer for keyborad Show/Hide
            NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewDidAppear(animated)
            // Remove observer for keybord Show/Hide
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
    @objc func keyboardWillShow (notification : NSNotification) {
            
            if mScrollView == nil {
                return
            }
            
            // adjust screen size on appearing keyboard
            let kbSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            if let activeField = findFirstResponder(view: mScrollView!) {
                
                let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize!.height, right: 0.0);
                mScrollView!.contentInset = contentInsets
                mScrollView!.scrollIndicatorInsets = contentInsets
                
                var aRect = self.view.frame
                aRect.size.height -= kbSize!.height
                if (!aRect.contains(activeField.frame.origin) ) {
                    mScrollView!.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
        
    @objc func keyboardWillHide (notification : NSNotification) {
            
            if mScrollView == nil {
                return
            }
            
            // adjust screen size on Hiding keyboard
            var contentInset = mScrollView!.contentInset
            contentInset.bottom = 0
            mScrollView!.contentInset = contentInset
            mScrollView!.scrollIndicatorInsets = contentInset
        }
        
        func findFirstResponder(view : UIView) -> UIView? {
            
            if view.isFirstResponder {
                return view
            }
            else {
                for subView in view.subviews {
                    
                    let responder: UIView? = findFirstResponder(view: subView )
                    if responder != nil {
                        return responder
                    }
                }
            }
            return nil
        }
    
    
}


//MARK:- textfield delegate
extension BaseViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
