//
//  GardenViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 22/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class GardenViewController: BaseViewController {

    var gardenList:[GardenModel] = []
    @IBOutlet weak var tableView: UITableView!
    var empID:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity?.startAnimating()
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGardenList()
    }
    
    
    //MARK:- get garden list
    func getGardenList()
    {
        if !isConnectedToInternet()
               {
               showAlert(title: "No Internet Connection", message:"Please check your internet connection")
               return
               }
            
               var headers = ["authorization":"Bearer \(SavedData.AuthToken)"]
                _ = WebService(action: API.GET_GARDEN_URL, postMethod: .post, parameters:nil, headers: headers, success: { (response, error) in
                    //handle and show garden list
                    self.gardenList.removeAll()
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
                           
                        }
                        self.tableView.reloadData()
                        }
                    }
                })
    }
    

}


//MARK:- tableview delegate and datasource
extension GardenViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gardenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gardenCell", for: indexPath) as! GarenViewTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = gardenList[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
          let cell = tableView.dequeueReusableCell(withIdentifier:"headerCell") as! HeaderTableViewCell
          cell.titleLabel.text = "Select garden"
          cell.selectionStyle = .none
          return cell.contentView
          
      }
      
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 60
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"StaffViewController") as! StaffViewController
        vc.gardenId = "\(gardenList[indexPath.row].id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
