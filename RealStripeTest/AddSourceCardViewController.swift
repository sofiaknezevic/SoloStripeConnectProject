//
//  AddSourceCardViewController.swift
//  RealStripeTest
//
//  Created by Sofia Knezevic on 2017-03-29.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit


class AddSourceCardViewController: UIViewController {


    var connectedAccountJSON:[String:Any]?
    let baseURLString = "http://localhost:4567/"
    
    let cardNumber = "4242424242424242"
    let expiryMonth = 9
    let expiryYear = 2020
    let cardCVC = "244"
    
    var cardJSON:[String:Any]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func getTokenButtonPushed(_ sender: UIButton)
    {
        
        getToken(cardNumber:cardNumber, expiryMonth: expiryMonth, expiryYear: expiryYear, cardCVC: cardCVC) { (cardDetails) in
            
            print("\(cardDetails["id"])")
            print("\(self.connectedAccountJSON)")
            
            //HAHAHAHAHAHAHAHA!!!!!! :)
            
        }
    }
    
    
    @IBAction func useTokenForChargePushed(_ sender: UIButton)
    {
        chargeSourceCardToConnectedAccount(connectedAccountJSON: connectedAccountJSON!, cardJSON:cardJSON!) { (chargeResponse) in
            
            
            
        }
        
    }


    func getToken(cardNumber:String, expiryMonth:Int, expiryYear:Int, cardCVC:String, completion:@escaping ([String:Any]) -> Void) {
        
        let path = "create_token"
        let url = baseURLString.appending(path)
        let realURL = URL(string: url)
        
        let params:[String:AnyObject] = [
            "number" : cardNumber as AnyObject,
            "exp_month" : expiryMonth as AnyObject,
            "exp_year" : expiryYear as AnyObject,
            "cvc" : cardCVC as AnyObject
        ]
        
        let request = URLRequest.request(realURL!, method: .POST, params: params)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            self.cardJSON = try! JSONSerialization.jsonObject(with: data!, options:[]) as! [String:Any]
            print("\(self.cardJSON)")
            
            
            DispatchQueue.main.async {

                completion(self.cardJSON!)
                
            
            }
    
    
        }
        
        task.resume()


    }
    
    
    
    func chargeSourceCardToConnectedAccount(connectedAccountJSON:[String:Any], cardJSON:[String:Any], completion:@escaping([String:Any]) -> Void) {
        
        let path = "charge_connected_account"
        let url = baseURLString.appending(path)
        let realURL = URL(string: url)
        
        let cardSource = cardJSON["id"] as! String
        let stripeID = connectedAccountJSON["stripe_user_id"] as! String
        
        let params:[String:AnyObject] = [
            "amount" : 100 as AnyObject,
            "currency" : "cad" as AnyObject,
            "source" : cardSource as AnyObject,
            "stripe_account" : stripeID as AnyObject
        ]
        
        let request = URLRequest.request(realURL!, method: .POST, params: params)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let chargeJSON = try! JSONSerialization.jsonObject(with: data!, options:[])
            print("\(chargeJSON)")
            
            DispatchQueue.main.async {
                
                completion(chargeJSON as! [String : Any])
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    

}
