//
//  OrderStatus.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit





extension OrderStatus {
    
    var rawValue: String {
        switch self {
        case .open: return "open"
        case .canceled: return "canceled"
        case .closed: return "closed"
        }
    }
    
}
