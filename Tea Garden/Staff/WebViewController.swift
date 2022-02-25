//
//  WebViewController.swift
//  Tea Garden
//
//  Created by Vandana Negi on 27/01/20.
//  Copyright © 2020 Vandana Negi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController,WKNavigationDelegate{
    
     let documentInteractionController = UIDocumentInteractionController()
    var fileName:String?

   
    

    var webView:WKWebView!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        activity?.startAnimating()
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        if let url = URL(string:url!) {
            let request = URLRequest(url: url)
            webView.load(request)
            activity?.stopAnimating()
        }
        documentInteractionController.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func storeAndShare(withURLString: String) {
           guard let url = URL(string: withURLString) else { return }
        print(url)
        self.activity?.startAnimating()
           URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { print(error); return }
            var tmpURL:URL!
           
            if #available(iOS 10.0, *) {
                
                 /*tmpURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(String(response?.suggestedFilename?.suffix(4).appending(".pdf") ?? "fileName.pdf"))*/
                tmpURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(self.fileName!.appending(".pdf"))
                
              
            } else {
                // Fallback on earlier versions
//                tmpURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(String(response?.suggestedFilename?.suffix(4).appending(".pdf") ?? "fileName.pdf"))
                tmpURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(self.fileName!.appending(".pdf"))
                
             
            }
            print(tmpURL)
               do {
                   try data.write(to: tmpURL)
               } catch {
                   print(error)
               }
               DispatchQueue.main.async {
                self.activity?.stopAnimating()
                self.share(url: tmpURL!)
               }
               }.resume()
       }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    {
          print(error.localizedDescription)
     }
     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
     {
          print("Strat to load")
     }
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
     {
          print("finish to load")
     }
    
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        print(url)
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
         documentInteractionController.delegate = self
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }

    }
    
    

    
   func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated
                    {
                      decisionHandler(.cancel)
                       self.storeAndShare(withURLString:"\(navigationAction.request.url!)")
                        return
                    }
            decisionHandler(.allow)
       
      }
    
    

}


extension WebViewController: UIDocumentInteractionControllerDelegate {
    /// If presenting atop a navigation stack, provide the navigation controller in order to animate in a manner consistent with the rest of the platform
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
