//
//  StaffViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 21/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//


import UIKit
import NVActivityIndicatorView

class StaffViewController: BaseViewController {

    var userList:[StaffModel] = []
    var gardenId:String?
//    var pageLimit:Int?
//    var pageCount:Int?
//    var currentPage:Int?
//    var totalData:Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.alpha = 0
        self.tableView.estimatedRowHeight = 20
        self.tableView.rowHeight = UITableView.automaticDimension
       
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getStaffData()
        
    }
    
    
    func getStaffData()
    {
        if !isConnectedToInternet()
        {
        showAlert(title: "No Internet Connection", message:"Please check your internet connection")
         return
        }
         self.activity?.startAnimating()
        let headers = ["authorization":"Bearer \(SavedData.AuthToken)"] as [String : Any]
        let dic = ["page":1,"gardenId":gardenId ?? "51","limit":100] as [String : Any]
        //var dic = ["gardenId":1,"limit":10,"page":1]
 
    
        print(headers)
               _ = WebService(action: API.GET_EMPLOYEE_LIST, postMethod: .post, parameters:dic, headers: headers, success: { (response, error) in
                    self.activity?.stopAnimating()
                   //handle and show user lists
                print(response)
                self.userList.removeAll()
                if let data = response?.dictionaryObject
                {
                    if data["status"] as? Bool ?? false == true{
                       
                        if let value = data["data"] as? [Any]
                        {
                            if value.count > 0
                            {
                                for item in value
                                {
                                    let _item = StaffModel(dic: item as! [String:Any])
                                    self.userList.append(_item)
                                }
                                
                            }
                            else{
                                
                            }
                        }
                                 self.tableView.alpha = 1
                               self.tableView.reloadData()
                    }
                    else{
                        showAlert(title:"", message:"Something went wrong")
                       // return
                       
                        self.tableView.alpha = 1
                        self.tableView.reloadData()
                    }
                }
                
               })
    }
    
    
    
    //MARK:- save user status
   @objc func saveStaffData(sender:UIButton)
    {
        if userList[sender.tag].isActive
               {
                   sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                   UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                       sender.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
                       sender.transform = .identity
                   }, completion: nil)
               }
               else{
                   sender.transform = CGAffineTransform(scaleX: 0, y: 0)
                   UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                       sender.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
                       sender.transform = .identity
                   }, completion: nil)
               }
            
        if !isConnectedToInternet()
               {
               showAlert(title: "No Internet Connection", message:"Please check your internet connection")
                return
               }
                self.activity?.startAnimating()
               let headers = ["authorization":"Bearer \(SavedData.AuthToken)"] as [String : Any]
        let dic = ["id":userList[sender.tag].id ?? 0,"is_active":userList[sender.tag].isActive ? 0 : 1] as [String : Any]
               //var dic = ["gardenId":1,"limit":10,"page":1]
         
           print(dic)
        print(API.SAVE_EMPLOYEE_STATUS)
               print(headers)
                      _ = WebService(action: API.SAVE_EMPLOYEE_STATUS, postMethod: .post, parameters:dic, headers: headers, success: { (response, error) in
                           self.activity?.stopAnimating()
                          //handle and show user lists
                       if let data = response?.dictionaryObject
                       {
                           if data["status"] as? Bool ?? false == true{
                           self.userList[sender.tag].isActive = !self.userList[sender.tag].isActive
                           }
                           else{
                               //do something
                           }
                       }
                       
                      })
    }
    
    
    //MARK:- edit button tapped
    @objc func editButtonTapped(sender:UIButton)
    {
        openStaffView(isEdit:true,tag:sender.tag)
    }
    
    //MARK:- edit button tapped
    @objc func addButtonTapped()
    {
       openStaffView(isEdit:false,tag:nil)
    }
    
    
    func openStaffView(isEdit:Bool,tag:Int?)
    {
       let storyboard = UIStoryboard(name: "AddStaff", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddStaffViewController") as! AddStaffViewController
        vc.groupID = gardenId ?? ""
        if isEdit
        {
           vc.employeeDetail = userList[tag ?? 0]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func accessButtonTapped(sender:UIButton)
       {
        let storyboard = UIStoryboard(name: "AddStaff", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"AccessUserViewController") as! AccessUserViewController
        vc.gardenID = gardenId ?? ""
        vc.userID = userList[sender.tag].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
       }
    

}


//MARK:- uitablevieew delegate and datasource
extension StaffViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == userList.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"buttonCell") as! ButtonTableViewCell
            cell.mainButton.setTitle("Add Staff", for: .normal)
            cell.mainButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return cell
        }
        else{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "staff", for: indexPath) as! StaffListTableViewCell
            cell.bgView.layer.cornerRadius = 6
        cell.nameLabel.text =  "\(userList[indexPath.row].username ?? "")"
        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        cell.accessButton.addTarget(self, action: #selector(accessButtonTapped), for: .touchUpInside)
            cell.statusButton.addTarget(self, action: #selector(saveStaffData(sender:)), for: .touchUpInside)
            cell.statusButton.tag = indexPath.row
        cell.accessButton.tag = indexPath.row
            cell.statusButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
            if userList[indexPath.row].isActive
            {
           cell.statusButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
            }
            
        return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //for pagination
        
    }
    
}
