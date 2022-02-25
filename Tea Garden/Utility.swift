//
//  Utility.swift
//  Tea Garden
//
//  Created by Vandana Negi on 04/12/19.
//  Copyright © 2019 Vandana Negi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


// validate string with only alphabets
  func isValidString(text: String) -> Bool {
    
    let stringRegEx = "^[a-zA-Z]+$"
    let stringTest = NSPredicate(format: "SELF MATCHES %@", stringRegEx)
    let result = stringTest.evaluate(with: text)
    return result
}

func isValidMobile(value: String) -> Bool {
    
    let PHONE_REGEX = "^[789]\\d{9}$"
    
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    
    let result =  phoneTest.evaluate(with: value)
    
    return result
}

//validate email address
func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    let result = emailTest.evaluate(with: testStr)
    
    return result
    
}

let NEW_DATE_FORMAT = "yyyy/MM/dd"


 func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
}

func appDelegate()->AppDelegate
{
    var delegate = UIApplication.shared.delegate as? AppDelegate
    return delegate!
}


  func checkInterConnection() -> Bool{
    return NetworkReachabilityManager()!.isReachable
}

//validate password
 func isValidPassword(text:String)->Bool{
    let stringRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+-=])(?=\\S+$).{8,}$"
    // let stringRegEx = "^(?=.{8,})(?=.*[0-9])(?=.*[a-zA-Z])([@#$%^&=a-zA-Z0-9_-]+)$"
    let stringTest = NSPredicate(format: "SELF MATCHES %@", stringRegEx)
    let result = stringTest.evaluate(with: text)
    return result
}

//MARK:- show alert message
func showAlert(title:String?,message:String?)
{
let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
let action = UIAlertAction(title: "OK", style: .default, handler:.none)
    alert.addAction(action)
appDelegate().window?.rootViewController?.present(alert, animated: false, completion: nil)

}

//convert NSDate to String in provided outputStringFormat
func convertTodayDateToString(date: NSDate,inputStringFormat:String?) -> String? {
    
    let dateFormatter = DateFormatter()
    let UI_DATE_FORMAT = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: UI_DATE_FORMAT)
    let calendar = Calendar.current
    dateFormatter.dateFormat = inputStringFormat ?? UI_DATE_FORMAT
    var dateStr = dateFormatter.string(from: date as Date)
    return dateStr;
    
}


//Convert String to NSDate
func convertStringToDateTime(dateStr: String) -> NSDate? {
    
    let dateFormatter = DateFormatter()
    let UI_DATE_FORMAT = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: UI_DATE_FORMAT)
    dateFormatter.dateFormat = UI_DATE_FORMAT
    let date = dateFormatter.date(from: dateStr)
    return date as NSDate?
}


func getDateBeforeDays(days:Int)->String?
{
  let dateFormatter = DateFormatter()
    let UI_DATE_FORMAT = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: UI_DATE_FORMAT)
    let calendar = Calendar.current
    dateFormatter.dateFormat = UI_DATE_FORMAT
    let fromDate = Calendar.current.date(byAdding: .day, value: -days, to: Date())
    var dateStr = dateFormatter.string(from: fromDate as! Date)
    return dateStr;
}


func changeMonth(month:Int) -> String? {
    let dateFormatter = DateFormatter()
    let UI_DATE_FORMAT = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: UI_DATE_FORMAT)
    let calendar = Calendar.current
    var dateComponents: DateComponents? = calendar.dateComponents([.year,.hour, .minute, .second], from: Date())
    dateComponents?.month = month
    let newDate: Date? = calendar.date(from: dateComponents!)
    dateFormatter.dateFormat = UI_DATE_FORMAT
    var dateStr = dateFormatter.string(from: newDate as! Date)
    return dateStr;
}


