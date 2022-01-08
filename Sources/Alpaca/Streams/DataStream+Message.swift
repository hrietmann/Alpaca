//
//  DataStream+Message.swift
//  Alpaca
//
//  Created by Hans Rietmann on 19/12/2021.
//

import Foundation




extension DataStream {
    
    
    
    struct Message: Codable {
        enum Action: String, Codable {
            case auth, subscribe, unsubscribe
        }
        let action: Action
        var key: String? = nil
        var secret: String? = nil
        var trades: Set<String>? = nil
        var quotes: Set<String>? = nil
        var bars: Set<String>? = nil
        var dailyBars: Set<String>? = nil
    }
    
    
    
}
