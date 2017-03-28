//
//  ConnectAuthViewController.swift
//  RealStripeTest
//
//  Created by Sofia Knezevic on 2017-03-24.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

protocol ServerInformationDelegate:class {
    
    func gimmeJSON(newJSON:[String:Any])
    
}


class ConnectAuthViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var stripeWebView: UIWebView!
    
    weak var delegate:ServerInformationDelegate?
    
    let newStuff = PossibleServerStuff()
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authURL = URL(string: "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_AKvPJVtMwPNyOtjb04bHnsxiQUCamFqV&scope=read_write")
        
        stripeWebView.loadRequest(URLRequest(url: authURL!))
        
        
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            
            return true
            
        }
        
        guard url.host == "www.sofia.com" else {
            
            return true
            
        }
        
  

        
        var authorizationToken = url.absoluteString.components(separatedBy: "code=")
        
        if authorizationToken[1].hasPrefix("ac_") {
            
            //save this somewhere
            
            newStuff.postToNetwork(code: authorizationToken[1]){ response in
                
                self.delegate?.gimmeJSON(newJSON: self.newStuff.currentJSON)
                
            }
            
            
            
            self.dismiss(animated: true, completion: nil)
            
            
            
        }
        
        
        
        return true
        
    }


}
