//
//  Fees.swift
//  Alpaca
//
//  Created by Hans Rietmann on 13/12/2021.
//

import Foundation
import TradeKit




struct Fees: TradeKit.Fees {
    
    var makerFee: Amount { .percent(value: 0) }
    var takerFee: Amount { .percent(value: 0) }
    
}
