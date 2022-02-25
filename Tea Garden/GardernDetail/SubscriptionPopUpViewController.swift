//
//  SubscriptionPopUpViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 29/02/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit

class SubscriptionPopUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myString = """
PLEASE GO TO WWW.ZOVINI.COM FROM YOUR LAPTOP OR COMPUTER \nCLICK "WANT TO SUBSCRIBE" BUTTON IN TOP PANEL FILL FORM AND SUBMIT
"""
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        var myRange = NSRange(location: 13, length: 14)

        let myAttrString = NSMutableAttributedString(string: myString)
        myAttrString.addAttributes(myAttribute, range: myRange)
        
        var myRange2 = NSRange(location: 63, length: 20)
        let myAttribute2 = [ NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)]
        myAttrString.addAttributes(myAttribute2, range: myRange2)
        // set attributed text on a UILabel
        titleLabel.attributedText = myAttrString
        titleLabel.textAlignment = .center
        
        // Do any additional setup after loading the view.
    }
 
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
