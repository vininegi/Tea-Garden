//
//  WebService.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit
import Alamofire 
import SwiftyJSON

class WebService: NSObject {
    
    var url:String!
    var parameters: [String:Any]!
    var headers:[String:Any]!
    var success:(_ data:JSON?, _ error:String?)-> Void
    var postType:HTTPMethod!
    
    
    init(action:String,postMethod:HTTPMethod,parameters: [String:Any]?,headers:[String:Any]?, success:@escaping (_ data:JSON?
        , _ error:String?)->Void) {
        self.success = success
        self.url = action
        self.parameters = parameters
        self.headers = headers
        self.postType = postMethod
         super.init()
        self.loadRequest()
     
    }
    
    
    
  func loadRequest() {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20
    
        if NetworkReachabilityManager()!.isReachable
        {
            if url == API.GET_EMPLOYEE_LIST || url == API.SAVE_EMPLOYEE_ACCESS //|| url == API.GET_GARDEN_DETAIL_LIST
            {
                Alamofire.request(url, method: postType, parameters: parameters, encoding:JSONEncoding.default, headers: headers as? HTTPHeaders ?? [:])/*.validate(statusCode: 200..<300).validate(contentType: ["application/json"])*/.responseJSON { (response) in
                               switch response.result {
                               case .success(let value):
                                   let json = JSON(value)
                                   print("JSON: \(json)")
                                   self.success(json,nil)
                               case .failure(let error):
                                   print(error)
                                   self.success(nil, error.localizedDescription)
                               }
                           }
            }
            else{
          Alamofire.request(url, method: postType, parameters: parameters, headers: headers as? HTTPHeaders ?? [:])/*.validate(statusCode: 200..<300).validate(contentType: ["application/json"])*/.responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    self.success(json,nil)
                case .failure(let error):
                    print(error)
                    self.success(nil, error.localizedDescription)
                }
            }
            }
    }
        else{
            let alert = UIAlertController(title: "Error", message:"No internet connection.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { action in
                switch action.style{
                    
                case .default:
                    self.loadRequest()
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("descriptive")
                }
            }))
            
        }
    }
    
    

}
