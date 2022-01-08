//
//  Order+OrderType.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




extension Order {
    
    
    enum OrderType: String, Codable {
        case market, asset, limit, stop, stop_limit, trailing_stop
    }
    
    
}
