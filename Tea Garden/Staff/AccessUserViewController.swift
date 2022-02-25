//
//  AccessUserViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 22/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit


class AccessUserViewController: BaseViewController{
    
    var accessModel:AccessModel?
    var userID:Int?
    var gardenID:String?
    @IBOutlet weak var tableView: UITableView!
    var dataDictionary:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableView.automaticDimension
        getEditAccess()
        registerScrollView(scrollView: tableView)
        let tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(doneButtonTapped))
        view.addGestureRecognizer(tapRecognizer)
           tableView.keyboardDismissMode = .onDrag
       
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        saveData()
    }
    
    
    
    @objc func doneButtonTapped()
    {
        self.view.endEditing(true)
    }
    
    //MARK:- get access of user
    func getEditAccess()
    {
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        self.activity?.startAnimating()
        let headers = ["authorization":"Bearer \(SavedData.AuthToken)"] as [String : Any]
        let dic = ["id":userID ?? 42]
        _ = WebService(action: API.GET_EMPLOYEE_DATA_AND_GARDEN, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            self.activity?.stopAnimating()
            
            print("response",response)
            //handle and show user lists
            if let data = response?.dictionaryObject
            {
                if data["status"] as? Bool ?? false == true{
                    if let gardens = data["gardens"] as? [Any]
                    {
                        if gardens.count > 0
                        {
                            for i in 0..<gardens.count
                            {
                                let _item = gardens[i] as? [String:Any]
                                if _item!["id"] as? Int ?? 0 == Int(self.gardenID ?? "51")
                                {
                                    self.accessModel = AccessModel(dic: gardens[i] as! [String:Any])
                                    self.tableView.reloadData()
                                    break
                                }
                            }
                            
                        }
                    }
                }
                else{
                    showAlert(title:"", message:"Something went wrong")
                    return
                }
            }
            
        })
        
    }
    
    
    
    func setDataInDic()
    {
        if accessModel != nil{
            var dataArray:[Any] = []
            if (accessModel?.reports.count)! > 0
            {
                for item in accessModel!.reports
                {
                    if item.hasAccess
                    {
                    let dic = ["type":"report","access":item.id ?? "","days":item.days ?? 0] as [String : Any]
                    dataArray.append(dic)
                    }
                }
            }
            if (accessModel?.sheets.count)! > 0
            {
                for item in accessModel!.sheets
                {
                    if item.hasAccess
                    {
                    let dic = ["type":"sheet","access":item.id ?? "","days":item.days ?? 0] as [String : Any]
                   dataArray.append(dic)
                    }
                }
            }
            dataDictionary["mainDic"] = dataArray
        }
    }
    
    
    
    
    
    //MARK:- save user's access data
    func saveData()
    {
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        setDataInDic()
        let dic:[String:Any] = ["userId":userID ?? 0,"useraccess":[["gardenId":Int(gardenID ?? "")!,"userId":userID ?? 0,"gardenuseraccesses":dataDictionary["mainDic"]!]]]
  
        
        self.activity?.startAnimating()
        let headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        print(dic)
        _ = WebService(action: API.SAVE_EMPLOYEE_ACCESS, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            self.activity?.stopAnimating()
            //handle and show user lists
            
            if let data = response?.dictionaryObject
            {
                if data["status"] as? Bool ?? false == true{
                    
                    showAlert(title:"Success", message:"Submitted successfully")
                }
                else{
                    showAlert(title:"", message:"Something went wrong")
                    return
                }
            }
            
        })
    }
    
   
    
}


//MARK:- tableview delegate and datasource
extension AccessUserViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if accessModel != nil
        {
            
            if section == 0
            {
                return (accessModel?.sheets.count)!
            }
            else{
                return (accessModel?.reports.count)!
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if accessModel != nil
        {
            return 2
        }
        return 0
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !tableView.isDecelerating {
            //self.view.endEditing(true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"headerCell") as! HeaderTableViewCell
        if section == 0
        {
            cell.titleLabel.text = "DATA ENTRY SHEETS"
        }
        else{
            cell.titleLabel.text = "REPORTS"
        }
        cell.selectionStyle = .none
        return cell.contentView
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return
    {
        textField.resignFirstResponder()
        return true
    }
    
    //check button tapped
    @objc func checkButtonTapped(sender:UIButton)
    {
        print(sender.tag)
        let section = sender.tag/1000
        let tag = sender.tag%1000
        print(tag)
        print(section)
        var data:SheetModel?
        if section == 0
        {
            data = accessModel?.sheets[tag]
        }
        else
        {
            data = accessModel?.reports[tag]
        }
        if data!.hasAccess
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
        data?.hasAccess = !data!.hasAccess
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil{
            accessModel?.sheets[textField.tag].days = Int(textField.text ?? "")
        }
    }
    
 
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text != nil{
            accessModel?.sheets[textField.tag].days = Int(textField.text ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reportsCell", for: indexPath) as! ReportsTableViewCell
            cell.nameLabel.text = accessModel?.sheets[indexPath.row].name ?? ""
            cell.daysTextField.text = nil
            if let day = accessModel?.sheets[indexPath.row].days
            {
                cell.daysTextField.text = "\(day)"
            }
            cell.checkButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
            
            if (accessModel?.sheets[indexPath.row].hasAccess)!
            {
                cell.checkButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
            }
            cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
            cell.daysTextField.tag = indexPath.row
            cell.checkButton.tag = indexPath.section*1000 + indexPath.row
            cell.daysTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                         for: UIControl.Event.editingChanged)
            
//            var toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
//            let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
//            let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//            toolbar.barTintColor = .white
//            toolbar.barStyle = .blackTranslucent
//            toolbar.items = [flex,donebutton]
//            self.view.addSubview(toolbar)
//            cell.daysTextField.inputAccessoryView = toolbar
            cell.daysTextField.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sheetCell", for: indexPath) as! SheetTableViewCell
            cell.checkButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
            cell.nameLabel.text = accessModel?.reports[indexPath.row].name ?? ""
            cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
            if (accessModel?.reports[indexPath.row].hasAccess)!
            {
                cell.checkButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
            }
            
            cell.checkButton.tag = indexPath.section*1000 + indexPath.row
            cell.selectionStyle = .none
            return cell
        }
        
    }
}
