//
//  AppDelegate.swift
//  Tea Garden
//
//  Created by Vandana Negi on 17/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var tabView:HomeViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if SavedData.isLoggedIn
        {
        //change condition when logged in
         openDashboardView()
        }
        else{
            setUpLoginView()
        }
       
        UINavigationBar.appearance().barTintColor = .white
      
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func openDashboardView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tabView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.window?.rootViewController = tabView
    }
    
    
    func openLoginView()
    {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewLoginViewController") as! NewLoginViewController
        let navc = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navc
    }
    
    
    //MARK:- Get auth token
    func getAuthToken(isRefresh:Bool)
    {
        let headers = ["cache-control":"no-cache","content-type":"application/x-www-form-urlencoded"]
        var dic = ["grant_type":"password","username":SavedData.UserName,"client_id":"demo","client_secret":"demo","password":SavedData.Password] as [String : Any]
        if isRefresh
        {
            dic["refresh_token"] = SavedData.RefreshToken
        }
        _ = WebService(action: API.REFRESH_TOKEN_URL, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            // handle response
            if let value = response?.dictionaryObject
            {
                SavedData.AuthToken = value["access_token"] as? String ?? ""
                SavedData.RefreshToken = value["refresh_token"] as? String ?? ""
            }
            
            
        })
    }

    
    //MARK:- set up login view
    func setUpLoginView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navc = UINavigationController(rootViewController: vc)
        SavedData.AuthToken = ""
        SavedData.isLoggedIn = false
        self.window?.rootViewController = navc
    }
    

}

