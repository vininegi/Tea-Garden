//
//  StaffModel.swift
//  Tea Garden
//
//  Created by Vandana Negi on 21/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

//MARK:- staff model
class StaffModel: NSObject {
    
    var keyPersonName:String?
    var address:String?
    var isActive:Bool = false
    var roleId:Int?
    var password:String?
    var mobile:String?
    var username:String?
    var userType:String?
    var masterID:Int?
    var email:String?
    var dob:String?
    var id:Int?
    var name:String?
    var gardenId:String?
    
    init(dic:[String:Any]) {
         keyPersonName = dic["key_person_name"] as? String
         address = dic["address"] as? String
        if let data = dic["is_active"] as? Int
        {
          if data == 1
           {
            isActive = true
            }
          
        }
         
         roleId = dic["roleId"] as? Int
         password = dic["password"] as? String
         mobile = dic["mobile"] as? String
         username = dic["username"] as? String
         userType = dic["user_type"] as? String
         masterID = dic["masterId"] as? Int
         email = dic["email"] as? String
         dob = dic["dob"] as? String
         id = dic["id"] as? Int
         name = dic["name"] as? String
    }
    

}




//MARK:- accces staff model
class AccessModel:NSObject
{
    var sheets:[SheetModel] = []
    var reports:[SheetModel] = []
    var id:Int?
    var name:String?
    
    
    init(dic:[String:Any]) {
        
         id = dic["id"] as? Int
         name = dic["name"] as? String
        if let data = dic["reports"] as? [Any]
        {
            if data.count > 0
            {
                for item in data{
                    let _item = SheetModel(dic: item as! [String:Any])
                    reports.append(_item)
                }
            }
        }
        if let data = dic["sheets"] as? [Any]
               {
                   if data.count > 0
                   {
                       for item in data{
                           let _item = SheetModel(dic: item as! [String:Any])
                           sheets.append(_item)
                       }
                   }
               }
    }
    
    

}


//Sheet model
class SheetModel:NSObject{
    var hasAccess:Bool = false
    var id:String?
    var name:String?
    var days:Int?
    var isAvailable:Bool = false
    
    init(dic:[String:Any]) {
        
        hasAccess = dic["hasAccess"] as? Bool ?? false
        isAvailable = dic["available"] as? Bool ?? false
        id = dic["id"] as? String
        days = dic["days"] as? Int
        name = dic["name"] as? String
        
    }
}


// MARK:- access model
class GardenDetailModel:NSObject
{
   
       var title:String?
       var items:[SheetModel] = []
       
       init(dic:[String:Any]) {
           
           title = dic["title"] as? String ?? ""
        if let data = dic["items"] as? [Any]
        {
            if data.count > 0
            {
                for item in data{
                    let _item = SheetModel(dic: item as! [String:Any])
                    items.append(_item)
                }
            }
        }
        
           
       }
}
