//
//  File.swift
//  
//
//  Created by Hans Rietmann on 30/12/2021.
//

import Foundation
import TradeKit



struct AZERTUYIO: TradeKit.Asset {
    
    let id: UUID
    let `class`: TradeKit.AssetClass
    let exchange: Exchange
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
