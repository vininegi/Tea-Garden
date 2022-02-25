//
//  GardenModel.swift
//  Tea Garden
//
//  Created by Vandana Negi on 01/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class GardenModel: NSObject {
    
    var name:String?
    var masterID:Int?
    var id:Int?
    var isActive:Bool = false
    
    
    init(dic:[String:Any]) {
        name = dic["name"] as? String
        masterID = dic["masterId"] as? Int
        id = dic["id"] as? Int
        if let data = dic["is_active"] as? Int
        {
            if data == 1
            {
                isActive = true
            }
            else{
                isActive = false
            }
        }
        
    }
   

}
