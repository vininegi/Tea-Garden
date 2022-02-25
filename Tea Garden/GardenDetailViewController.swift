//
//  GardenDetailViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 25/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import UIKit

class GardenDetailViewController: BaseViewController {
    var garden:GardenModel?
    var gardenData:[GardenDetailModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedSectionFooterHeight = 1
        tableView.sectionFooterHeight = UITableView.automaticDimension
     
        getGardenDetail()
        
    }
    
    
    
    
    
    //MARK:- button tapped
    @objc func buttonTapped(sender:UIButton)
    {
        self.activity?.startAnimating()
        let section = sender.tag/1000
        let tag = sender.tag%1000
        if let data = gardenData[section].items as? [SheetModel]
        {
            
            let date = convertTodayDateToString(date: NSDate(), inputStringFormat: nil)  ?? ""
            var dic = ["report":data[tag].id ?? "","gardenId":garden?.id ?? 0,"start":date,"end":date] as [String : Any]
           
            self.activity?.stopAnimating()
             print(dic)
            if !data[tag].isAvailable
            {
                openComingSoonPopUp()
                return
            }
            if data[tag].id ?? "" == "green-leaf"
            {
                dic["type"] = "bought_leaf"
                self.callTokenApi(dic: dic)
            }
            else if data[tag].id ?? "" == "green-leaf-own"
            {
                dic["type"] = "own_leaf"
                self.callTokenApi(dic: dic)
            }
            else if data[tag].id ?? "" == "green-leaf-party-wise" || data[tag].id ?? "" == "green-leaf-sector-wise" || data[tag].id ?? "" == "green-leaf-fine-percentage-analysis" ||  data[tag].id ?? "" == "periodical-manufacturing"
            {
                if data[tag].id ?? "" == "periodical-manufacturing"
                {
                    dic["view"] = "periodical"
                    dic["report"] = "manufacturing"
                }
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"SelectDateViewController") as! SelectDateViewController
                vc.onTap = {[weak self] (startDate,endDate) -> Void in
                    dic["start"] = startDate ?? ""
                    dic["end"] = endDate ?? ""
                    self?.activity?.startAnimating()
                    self?.callTokenApi(dic: dic)
                }
                
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else if data[tag].id ?? "" == "daily-manufacturing"
            {
                dic["view"] = "daily"
                dic["report"] = "manufacturing"
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"SelectDateViewController")
                    as! SelectDateViewController
                vc.isSingle = true
                               vc.onTap = {[weak self] (startDate,endDate) -> Void in
                                   dic["start"] = startDate ?? ""
                                   dic["end"] = startDate ?? ""
                                   self?.activity?.startAnimating()
                                   self?.callTokenApi(dic: dic)
                               }
                  self.activity?.stopAnimating()
                self.navigationController?.pushViewController(vc, animated: false)
               // self.callTokenApi(dic: dic)
            }
            else if data[tag].id ?? "" == "long-financial"
            {
                 // dic["report"] = "financial"
                 dic["view"] = "periodical"
                 self.callTokenApi(dic: dic)
            }
            else if data[tag].id ?? "" == "last-day-delivery"
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"SelectDaysViewController") as! SelectDaysViewController
                
                vc.onTap = {[weak self] (days) -> Void in
                    
                    let startDate = getDateBeforeDays(days: Int(days ?? "0")!)
                    dic["start"] = startDate ?? ""
                    dic["end"] = date ?? ""
                    print(dic)
                    self?.activity?.startAnimating()
                    self?.callTokenApi(dic: dic)
                }
                self.activity?.stopAnimating()
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else if data[tag].id ?? "" == "month-manufacturing"
            {
                dic["view"] = "monthly"
                dic["report"] = "manufacturing"
                let vc = self.storyboard?.instantiateViewController(withIdentifier:"SelectMonthViewController") as! SelectMonthViewController
                
                vc.onTap = {[weak self] (month) -> Void in
                    //dic["month"] = month
                    let newDate = changeMonth(month: month ?? 0)
                    dic["start"] = newDate
                    dic["end"] = newDate
                    self?.activity?.startAnimating()
                    self?.callTokenApi(dic: dic)
                    
                }
                self.activity?.stopAnimating()
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else{
                self.callTokenApi(dic: dic)
            }
        }
        
        
        
    }
    
    
    
    
    
    func getGardenDetail()
    {
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        var headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        let dic = ["gardenId":garden?.id ?? 0]
        print(dic)
        print(API.GET_GARDEN_DETAIL_LIST)
        _ = WebService(action: API.GET_GARDEN_DETAIL_LIST, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            print(response)
            // handle response
            self.activity?.stopAnimating()
            if let value = response?.dictionaryObject
            {
                if value["status"] as? Bool == true{
                    if let accessData = value["access_reports"] as? [Any]
                    {
                        if accessData.count > 0
                        {
                            for item in accessData
                            {
                                let _item = GardenDetailModel(dic: item as! [String:Any])
                                self.gardenData.append(_item)
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
            
            
        })
        
    }
    
    
    
    func openComingSoonPopUp()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"CominSoonPopUpViewController") as! CominSoonPopUpViewController
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: false, completion: nil)
    }
    
    func callTokenApi(dic:[String:Any])
    {
        print(dic)
        if !isConnectedToInternet()
        {
            showAlert(title: "No Internet Connection", message:"Please check your internet connection")
            return
        }
        
        var headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
        _ = WebService(action: API.GET_GARDEN_REPORT, postMethod: .post, parameters: dic, headers: headers, success: { (response, error) in
            
            print(response)
            // handle response
            self.activity?.stopAnimating()
            if let value = response?.dictionaryObject
            {
                if value["status"] as? Bool == true{
                    let date = convertTodayDateToString(date: NSDate(), inputStringFormat: nil)  ?? ""
                    var name = "\(dic["report"]!)"
                    if dic["start"] as! String == dic["end"] as! String && dic["start"] as! String == date
                    {
                        name = "\(name)_report_today"
                    }
                    else{
                        let format = "MMM dd, yyyy"
                        let start = convertStringToDateTime(dateStr: dic["start"]! as! String)
                        let newStart = convertTodayDateToString(date:start!, inputStringFormat: format)
                        let end = convertStringToDateTime(dateStr: dic["end"]! as! String)
                        let newEnd = convertTodayDateToString(date:end!, inputStringFormat: format)
                        name = "\(name)_report_\(newStart!)"+"-"+"\(newEnd!)"
                    }
                    self.showWebView(token: value["token"] as! String, reportName: name)
                }
                //                SavedData.AuthToken = value["access_token"] as? String ?? ""
                //                SavedData.RefreshToken = value["refresh_token"] as? String ?? ""
            }
            
            
        })
    }
    
    //show data in safari
    func showWebView(token:String,reportName:String)
    {
        let url = API.SHOW_REPORT_IN_WEB + token
        print(url)
        if let _url = URL(string: url) {
            let vc = WebViewController()
            vc.url = url
            vc.fileName = reportName
            self.navigationController?.pushViewController(vc, animated: true)
            /*if #available(iOS 10.0, *) {
             UIApplication.shared.open(url)
             } else {
             // Fallback on earlier versions
             UIApplication.shared.openURL(url)
             }*/
        }
    }
    
    
}


//MARK:- tableview delegate and datasource
extension GardenDetailViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return gardenData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section",section)
        return gardenData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"headerCell") as! HeaderTableViewCell
        cell.titleLabel.text = gardenData[section].title ?? ""
        cell.selectionStyle = .none
        return cell.contentView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
        cell.mainButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        cell.mainButton.setTitle(gardenData[indexPath.section].items[indexPath.row].name ?? "", for: .normal)
        cell.mainButton.tag = indexPath.section * 1000 + indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
}
