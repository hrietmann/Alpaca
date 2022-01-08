//
//  Account+Status.swift
//  Alpaca
//
//  Created by Hans Rietmann on 01/12/2021.
//

import Foundation





extension Account {
    
    
    /// The following are the possible account status values. Most likely, the account status is ACTIVE unless there is any problem. The account status may get in ACCOUNT_UPDATED when personal information is being updated from the dashboard, in which case you may not be allowed trading for a short period of time until the change is approved.
    enum Status: String, Codable {
        
        /// The account is onboarding.
        case ONBOARDING
        
        /// The account application submission failed for some reason.
        case SUBMISSION_FAILED
        
        /// The account application has been submitted for review.
        case SUBMITTED
        
        /// The account information is being updated.
        case ACCOUNT_UPDATED
        
        /// The final account approval is pending.
        case APPROVAL_PENDING
        
        /// Account can trade crypto
        case APPROVED
        
        /// The account is active for trading.
        case ACTIVE
        
        /// The account application has been rejected.
        case REJECTED
    }
    
    
}
