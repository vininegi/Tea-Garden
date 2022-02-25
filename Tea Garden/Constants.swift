//
//  Constants.swift
//  Tea Garden
//
//  Created by Vandana Negi on 23/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.


import Foundation
import UIKit

//172.105.36.75:4000/"
//MAIN:- API urls
class API
{
    static let BASE_URL = "http://172.105.62.176:4000/"
    static let WEB_URL = "https://zovini.com/"
    static let REGISTRATION_URL = BASE_URL + "register-demo"
    static let LOGIN_URL = BASE_URL + "login"
    static let REFRESH_TOKEN_URL = BASE_URL + "oauth/token"
    static let FORGOT_PASSWORD_URL = BASE_URL + "forgot"
    static let GET_GARDEN_URL = BASE_URL + "garden"
    static let CHANGE_PASSWORD  = BASE_URL + "user/change-password"
    static let ADD_GARDEN = BASE_URL + "garden/save"
    static let EDIT_GARDEN = BASE_URL + "garden/edit"
    static let EDIT_STAFF = BASE_URL + "employee/edit"
    static let SAVE_EMPLOYEE_DATA = BASE_URL + "employee/save"
    static let GET_GARDEN_REPORT = BASE_URL + "report"
    static let GET_EMPLOYEE_LIST = BASE_URL + "employee"
    static let SHOW_REPORT_IN_WEB = WEB_URL + "report/"
    static let GET_EMPLOYEE_DATA_AND_GARDEN = BASE_URL + "employee/access"
    static let SAVE_EMPLOYEE_ACCESS = BASE_URL + "employee/save-access"
    static let SAVE_EMPLOYEE_STATUS = BASE_URL + "employee/status"
    static let GET_GARDEN_DETAIL_LIST = BASE_URL + "garden/actions"
    static let RESET_PASSWORD = BASE_URL + "resetpassword"
    
}



class StringKey
{
    static let AUTH_KEY = "auth_key"
    static let IS_LOGGED_IN = "isLoggedIn"
    static let CLIENT_SECRET = "clientSecret"
    static let CLIENT_ID = "clientID"
    static let USER_NAME = "username"
    static let PASSWORD = "password"
    static let REFRESH_TOKEN = "refresh_token"
}


class User
{
    static let STAFF = "user"
    static let ADMIN = "group"
}

let GREEN_COLOR = UIColor(red: 0/255.0, green: 100/255.0, blue: 0/255.0, alpha: 1.0)
let COLOR_ORANGE = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1.0)


//Preferences
class SavedData
{
static var AuthToken:String
{
    get
    {
        if let data = UserDefaults.standard.value(forKey: StringKey.AUTH_KEY) as? String
        {
            return data
        }
    return ""
    }
    set
    {
      UserDefaults.standard.set(newValue, forKey: StringKey.AUTH_KEY)
      UserDefaults.standard.synchronize()
    }
}

    static var RefreshToken:String
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.REFRESH_TOKEN) as? String
            {
                return data
            }
            return ""
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.REFRESH_TOKEN)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var UserName:String
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.USER_NAME) as? String
            {
                return data
            }
            return ""
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.USER_NAME)
            UserDefaults.standard.synchronize()
        }
    }
    static var Password:String
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.PASSWORD) as? String
            {
                return data
            }
            return ""
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.PASSWORD)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var UserType:String
     {
         get
         {
             if let data = UserDefaults.standard.value(forKey: "user_type") as? String
             {
                 return data
             }
            return User.ADMIN
         }
         set
         {
             UserDefaults.standard.set(newValue, forKey: "user_type")
             UserDefaults.standard.synchronize()
         }
     }
    
    static var ClientID:Int
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.CLIENT_ID) as? Int
            {
                return data
            }
            return 0
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.CLIENT_ID)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var ClientSecret:String
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.CLIENT_SECRET) as? String
            {
                return data
            }
            return ""
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.CLIENT_SECRET)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isLoggedIn:Bool
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: StringKey.IS_LOGGED_IN) as? Bool
            {
                return data
            }
            return false
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: StringKey.IS_LOGGED_IN)
            UserDefaults.standard.synchronize()
        }
    }
    
}
