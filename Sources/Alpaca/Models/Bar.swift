//
//  Bar.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation
import TradeKit



struct Bar: Codable {
    
    let t: String
    
    /// symbol
    let S: String?
    let x: Exchange?
    let o: Number
    let h: Number
    let l: Number
    let c: Number
    let v: Number
    let n: Number?
    let vw: Number?
    
    
}




extension Bar: Candle {
    public var open: Number { o }
    public var high: Number { h }
    public var low: Number { l }
    public var close: Number { c }
    public var volume: Number { v }
    public var date: Date { t.RFC3339! }
}
