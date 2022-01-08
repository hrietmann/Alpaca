//
//  Trade.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit






struct Trade: Codable {
    
    /// Symbol
    let S: String?
    
    /// trade ID
    let i: Int
    
    /// exchange code where the trade occurred
    let x: Exchange
    
    /// trade price
    let p: Number
    
    /// trade size
    let s: Number
    
    /// RFC-3339 formatted timestamp with nanosecond precision.
    let t: String
    
    /// trade condition
    let c: [String]?
    
    /// tape
    let z: String?
    
    
    struct Latest: Codable {
        let symbol: String
        let trade: Trade
    }
    
    
}



extension Trade: TradeKit.Trade {
    
    public var price: Double { p.value }
    public var size: Double { s.value }
    
}
