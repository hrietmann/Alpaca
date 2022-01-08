//
//  Order+TimeInForce.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation




extension Order {
    
    
    
    enum TimeInForce: String, Codable {
        
        /// A day order is eligible for execution only on the day it is live. By default, the order is only valid during Regular Trading Hours (9:30am - 4:00pm ET). If unfilled after the closing auction, it is automatically canceled. If submitted after the close, it is queued and submitted the following trading day. However, if marked as eligible for extended hours, the order can also execute during supported extended hours.
        case day
        
        /// The order is good until canceled. Non-assetable GTC limit orders are subject to price adjustments to offset corporate actions affecting the issue. We do not currently support Do Not Reduce(DNR) orders to opt out of such price adjustments.
        case gtc
        
        /// Use this TIF with a asset/limit order type to submit “asset on open” (MOO) and “limit on open” (LOO) orders. This order is eligible to execute only in the asset opening auction. Any unfilled orders after the open will be cancelled. OPG orders submitted after 9:28am but before 7:00pm ET will be rejected. OPG orders submitted after 7:00pm will be queued and routed to the following day’s opening auction. On open/on close orders are routed to the primary exchange. Such orders do not necessarily execute exactly at 9:30am / 4:00pm ET but execute per the exchange’s auction rules.
        case opg
        
        /// Use this TIF with a asset/limit order type to submit “asset on close” (MOC) and “limit on close” (LOC) orders. This order is eligible to execute only in the asset closing auction. Any unfilled orders after the close will be cancelled. CLS orders submitted after 3:50pm but before 7:00pm ET will be rejected. CLS orders submitted after 7:00pm will be queued and routed to the following day’s closing auction. Only available with API v2.
        case cls
        
        /// An Immediate Or Cancel (IOC) order requires all or part of the order to be executed immediately. Any unfilled portion of the order is canceled. Only available with API v2. Most asset makers who receive IOC orders will attempt to fill the order on a principal basis only, and cancel any unfilled balance. On occasion, this can result in the entire order being cancelled if the asset maker does not have any existing inventory of the security in question.
        case ioc
        
        /// A Fill or Kill (FOK) order is only executed if the entire order quantity can be filled, otherwise the order is canceled. Only available with API v2.
        case fok
    }
    
    
    
}
