//
//  ChooseRecipientViewController.swift
//  RealStripeTest
//
//  Created by Sofia Knezevic on 2017-03-23.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit
import Foundation

class ChooseRecipientViewController: UIViewController, ServerInformationDelegate {



    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        
        
    }
    
    @IBAction func connectWithStripe(_ sender: UIButton)
    {
        
        self.performSegue(withIdentifier: "showWebView", sender: self)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebView"  {
            
            let newVC = segue.destination as! ConnectAuthViewController
            newVC.delegate = self
            
            
        }
    }
    
    func gimmeJSON(newJSON:[String:Any]) {

        
        let newVC = ViewController(newJSON: newJSON)
        self.navigationController?.present(newVC, animated: true, completion: nil)
        
    }
    
    

}
