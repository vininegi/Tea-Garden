//
//  GardenListModel.swift
//  Tea Garden
//
//  Created by Vandana Negi on 27/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class LoginModel: NSObject {

    
    var mobileNum:String?
    var password:String?
    var userType:String?
    var address:String?
    var roleID:Int?
    var dob:String?
    var id:Int?
    var key_person_name:String?
    var masterId:String?
    var username:String?
    var gstNo:String?
    var token:String?
    var isActive:Int?
    var userPermission:[String] = []
    var gardenPermission:[String] = []
    var rolePermission:[String] = []
    var dashboardPermission:[String] = []
    var email:String?
    var name:String?
    
    
    init(dic:[String:Any]) {
        if let data = dic["permissions"] as? [String:Any]
        {
            if let value = data["User"] as? [String]
            {
                if value.count > 0
                {
                    userPermission = value
                }
            }
            if let value = data["Garden"] as? [String]
            {
                if value.count > 0
                {
                  gardenPermission = value
                }
            }
            if let value = data["Role"] as? [String]
            {
                if value.count > 0
                {
                    rolePermission = value
                }
            }
            if let value = data["Dashboard"] as? [String]
            {
                if value.count > 0
                {
                    dashboardPermission = value
                }
            }
        }
        
       mobileNum = dic["mobile"] as? String
         password = dic["password"] as? String
        SavedData.Password = password ?? ""
        
         userType = dic["user_type"] as? String
        SavedData.UserType = dic["user_type"] as? String ?? ""
         address = dic["address"] as? String
         roleID = dic["roleId"] as? Int
         dob = dic["dob"] as? String
         id = dic["id"] as? Int
        SavedData.ClientID = id ?? 0
        key_person_name = dic["key_person_name"] as? String
        masterId = dic["masterId"] as? String
        username = dic["username"] as? String
        SavedData.UserName = username ?? ""
        gstNo = dic["gst_no"] as? String
        name = dic["name"] as? String
        token = dic["token"] as? String
        SavedData.AuthToken = token ?? ""
        isActive = dic["is_active"] as? Int
         email = dic["email"] as? String
        
        
    }
   
}

