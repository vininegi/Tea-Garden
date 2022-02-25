//
//  AddGardenViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 24/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField



class AddGardenViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gardenName: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScrollView(scrollView: scrollView)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
       
        if !gardenName.hasText
        {
        showAlert(title: "Alert", message:"Please enter garden name")
        return
        }
       if !isConnectedToInternet()
        {
        showAlert(title: "No Internet Connection", message:"Please check your internet connection")
        return
        }
         self.activity?.startAnimating()
        //TO DO:- returning without calling api for now, will fix later
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             self.activity?.stopAnimating()
            self.gardenName.text = nil
                  appDelegate().tabView?.selectedIndex = 1
                   appDelegate().tabView?.selectedViewController =  appDelegate().tabView?.viewControllers![0]
            }
            return
        //id: 1 // for new garden remove "id" param
       let headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        let dic = ["is_active":1,"name":gardenName.text!] as [String : Any]
        _ = WebService(action: API.ADD_GARDEN, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            //handle
             self.activity?.stopAnimating()
             if let data = response?.dictionaryObject
                       {
                           if let status = data["status"] as? Bool, status == false
                           {
                              showAlert(title: "", message: "Something went wrong")
                              return
                           }
                           else
                           {
          
            //post notification for garden add
            NotificationCenter.default.post(name:NSNotification.Name("add_garden"), object: nil)
            appDelegate().tabView?.selectedIndex = 1
            appDelegate().tabView?.selectedViewController =  appDelegate().tabView?.viewControllers![0]
            }
            }
            //Show alert for successfully sent on reset password
            
        })
      
    }
    
}
