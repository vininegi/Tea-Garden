//
//  SettingsViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 23/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var passwordView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if SavedData.UserType == User.STAFF
        {
            passwordView.isHidden = true
        }
       
    }
    
    @IBAction func passwordButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
    //set back to login view
        
    let alert = UIAlertController(title: nil, message: "Are you sure you want to Logout?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
            appDelegate().setUpLoginView()
        }
        let action1 = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action1)
        self.navigationController?.present(alert, animated: true, completion: nil)
    
    }
    
}
