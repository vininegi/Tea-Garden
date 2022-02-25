//
//  DashboardViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/10/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {

    @IBOutlet weak var gardenStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gardenStackHeight: NSLayoutConstraint!
    var gardenList:[GardenModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var refresh = false
        if SavedData.RefreshToken != ""
        {
            refresh = true
        }
         self.activity?.startAnimating()
        getAuthToken(isRefresh: refresh)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: NSNotification.Name("add_garden"), object: nil)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    
    //refresh list
    @objc func refreshList()
    {
         self.activity?.startAnimating()
        gardenList.removeAll()
        for item in gardenStackView.arrangedSubviews
        {
            item.removeFromSuperview()
        }
         getGardensList()
    }
    
    
    //MARK:- Get auth token
    func getAuthToken(isRefresh:Bool)
    {
        if !isConnectedToInternet()
                 {
                    self.activity?.stopAnimating()
                 showAlert(title: "No Internet Connection", message:"Please check your internet connection")
                 return
                 }
        let headers = ["cache-control":"no-cache","content-type":"application/x-www-form-urlencoded"]
        var dic = ["grant_type":"password","username":SavedData.UserName,"client_id":"demo","client_secret":"demo","password":SavedData.Password] as [String : Any]
        if isRefresh
        {
            dic["refresh_token"] = SavedData.RefreshToken
        }
        _ = WebService(action: API.REFRESH_TOKEN_URL, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            self.activity?.stopAnimating()
            // handle response
            if let value = response?.dictionaryObject
            {
                if let status = value["status"] as? Bool, status == false
                {
                   showAlert(title: "", message: "Something went wrong")
                   return
                }
                else
                {
                SavedData.AuthToken = value["access_token"] as? String ?? ""
                SavedData.RefreshToken = value["refresh_token"] as? String ?? ""
                self.activity?.startAnimating()
                self.getGardensList()
                }
            }
           
            
        })
        
    }
    
    
    //MARK:- get
    func getGardensList()
    {
        var headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        _ = WebService(action: API.GET_GARDEN_URL, postMethod: .post, parameters:nil, headers: headers, success: { (response, error) in
            //handle and show garden list
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
                if let list = data["data"] as? [Any]
                {
                    if list.count > 0
                    {
                        for item in list{
                            let _item = GardenModel(dic: item as! [String:Any])
                            self.gardenList.append(_item)
                            
                        }
                    }
                    self.setData()
                }
                }
            }
        })
    }

    
    //set data in gardenstackview
    func setData()
    {
      for i in 0..<gardenList.count
      {
        let button = CustomButton()
        button.backgroundColor = GREEN_COLOR
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant:gardenStackView.frame.size.width).isActive = true
        button.setTitle(gardenList[i].name ?? "", for: .normal)
        button.tag = i
        button.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
        gardenStackView.addArrangedSubview(button)
        }
        gardenStackView.setNeedsLayout()
        gardenStackView.setNeedsDisplay()
    }
    
    
   
    @objc func onButtonTap(sender:UIButton)
    {
      if let data = gardenList[sender.tag] as? GardenModel
      {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GardenDetailViewController") as! GardenDetailViewController
        vc.garden = data
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
