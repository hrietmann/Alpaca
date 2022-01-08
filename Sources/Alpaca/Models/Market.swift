//
//  Market.swift
//  Alpaca
//
//  Created by Hans Rietmann on 13/12/2021.
//

import Foundation
import TradeKit




struct Market: Asset, Codable {
    
    let id: UUID
    let `class`: AssetClass
    let symbol: AssetSymbol
    let name: String?
    enum Status: String, Codable { case active, inactive }
    let status: Status
    let tradable: Bool
    let marginable: Bool
    let shortable: Bool
    let easy_to_borrow: Bool
    let fractionable: Bool
    
}
