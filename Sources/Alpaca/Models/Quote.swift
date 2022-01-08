//
//  Quote.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit





struct Quote: Codable {
    
    /// Symbol
    let S: String?
    
    /// exchange code
    let x: Exchange?
    
    /// ask exchange code
    let ax: Exchange?
    
    /// ask price
    let ap: Number
    
    /// ask size
    let `as`: Number
    
    /// bid exchange code
    let bx: Exchange?
    
    /// bid price
    let bp: Number
    
    /// bid size
    let bs: Number
    
    /// RFC-3339 formatted timestamp with nanosecond precision.
    let t: String
    
    /// quote condition
    let c: [String]?
    
    /// tape
    let z: String?
    
    
    struct Latest: Codable {
        let symbol: String
        let quote: Quote
    }
    
    
}




extension Quote: TradeKit.Quote {
    
    public var askPrice: Double { ap.value }
    public var askSize: Double { `as`.value }
    public var bidPrice: Double { bp.value }
    public var bidSize: Double { bs.value }
    
}
