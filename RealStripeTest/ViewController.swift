//
//  ViewController.swift
//  RealStripeTest
//
//  Created by Sofia Knezevic on 2017-03-22.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit
import Stripe

class ViewController: UIViewController, STPPaymentContextDelegate {
    
    
    //var stripePublishableKey = ""
//    let backendBaseURL: String? = "https://partystarter19.herokuapp.com/"
    let backendBaseURL: String? = "http://localhost:4567/"

    var paymentContext: STPPaymentContext
    let paymentCurrency = "CAD"
    var jsonOfUser:[String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    init(newJSON:[String:Any]) {
        
        
        let stripePublishableKey = newJSON["stripe_publishable_key"] as! String
        
        
        let backendBaseURL = self.backendBaseURL
        
                
        assert(stripePublishableKey.hasPrefix("pk_"), "You're missing your StripePublishableKey")
        
        assert(backendBaseURL != nil, "There is no back-end URL!")
        
        
        
        APIClient.sharedClient.baseURLString = self.backendBaseURL
        
        
        
        let paymentConfiguration = STPPaymentConfiguration.shared()
        
        paymentConfiguration.publishableKey = stripePublishableKey
        
        
        
        let paymentContext = STPPaymentContext(apiAdapter: APIClient.sharedClient,
                                               
                                               configuration: paymentConfiguration,
                                               
                                               theme: STPTheme.default())
        
        
        
        let userInformation = STPUserInformation()
        
        paymentContext.prefilledInformation = userInformation
        
        paymentContext.paymentAmount = 5000
        
        paymentContext.paymentCurrency = self.paymentCurrency
        
        
        self.paymentContext = paymentContext
        
        
        super.init(nibName: "View", bundle: nil)
        self.paymentContext.hostViewController = self
        self.jsonOfUser = newJSON
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }


    @IBAction func didTapPay(_ sender: UIButton) {
        
        
        self.paymentContext.requestPayment()
    }


 

    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        
        APIClient.sharedClient.completeCharge(paymentResult, userData:self.jsonOfUser!, amount: self.paymentContext.paymentAmount, completion: completion)
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You paid $50 randomly to nothing 🙃"
        case .userCancellation:
            return
            
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
            _ = self.navigationController?.popViewController(animated: true)
        
        }
        
        let retry = UIAlertAction(title: "Retry", style: .default) { action in
            
            self.paymentContext.retryLoading()
        }
        
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
 
        self.paymentContext = paymentContext
        
    }
  


}

