//
//  Order+Status.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation



extension Order {
    
    
    public enum Status: String, Codable {
        
        /// The order has been received by Alpaca, and routed to exchanges for execution. This is the usual initial state of an order.
        case new
        
        /// The order has been partially filled.
        case partially_filled
        
        /// The order has been filled, and no further updates will occur for the order.
        case filled
        
        /// The order is done executing for the day, and will not receive further updates until the next trading day.
        case done_for_day
        
        /// The order has been canceled, and no further updates will occur for the order. This can be either due to a cancel request by the user, or the order has been canceled by the exchanges due to its time-in-force.
        case canceled
        
        /// The order has expired, and no further updates will occur for the order.
        case expired
        
        /// The order was replaced by another order, or was updated due to a asset event such as corporate action.
        case replaced
        
        /// The order is waiting to be canceled.
        case pending_cancel
        
        /// The order is waiting to be replaced by another order. The order will reject cancel request while in this state.
        case pending_replace
        
        
        
        
        
        // - MARK: Less common states
        // Less common states are described below. Note that these states only occur on very rare occasions, and most users will likely never see their orders reach these states:
        /// The order has been received by Alpaca, but hasn’t yet been routed to the execution venue. This could be seen often out side of trading session hours.
        case accepted
        
        /// The order has been received by Alpaca, and routed to the exchanges, but has not yet been accepted for execution. This state only occurs on rare occasions.
        case pending_new
        
        /// The order has been received by exchanges, and is evaluated for pricing. This state only occurs on rare occasions.
        case accepted_for_bidding
        
        /// The order has been stopped, and a trade is guaranteed for the order, usually at a stated price or better, but has not yet occurred. This state only occurs on rare occasions.
        case stopped
        
        /// The order has been rejected, and no further updates will occur for the order. This state occurs on rare occasions and may occur based on various conditions decided by the exchanges.
        case rejected
        
        /// The order has been suspended, and is not eligible for trading. This state only occurs on rare occasions.
        case suspended
        
        /// The order has been completed for the day (either filled or done for day), but remaining settlement calculations are still pending. This state only occurs on rare occasions.
        case calculated
    }
    
    
}
