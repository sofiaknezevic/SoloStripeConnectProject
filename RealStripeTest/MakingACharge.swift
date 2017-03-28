//
//  MakingACharge.swift
//  RealStripeTest
//
//  Created by Sofia Knezevic on 2017-03-24.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit
import Stripe

class MakingACharge: NSObject, STPPaymentContextDelegate {

    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        
        
    }
    
}
