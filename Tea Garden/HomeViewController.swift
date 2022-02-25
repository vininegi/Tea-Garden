//
//  HomeViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 22/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit


class HomeViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // guard let tabBar = self.tabBarController?.tabBar else { return }
            
        tabBar.tintColor = UIColor.white
        //tabBar.barTintColor = UIColor.black
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = .black
        } else {
            
            // Fallback on earlier versions
        }
        showHideTabs()
    }
    
    
    
    func showHideTabs()
    {
        if SavedData.UserType == User.STAFF
        {
                if self.viewControllers!.count > 1 {
                    viewControllers?.remove(at: 1)
                    self.viewControllers = viewControllers
                }
            
        }
    }


}
