//
//  Asset+Entity.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit





extension Market {
    
    
    struct Entity: Codable {
        let id: UUID
        
        enum Class: String, Codable {
            case equity = "us_equity"
        }
        let `class`: Class
        let exchange: Exchange
        let symbol: AssetSymbol
        
        enum Status: String, Codable {
            case active, inactive
        }
        let status: Status
        let tradable: Bool
        let marginable: Bool
        let shortable: Bool
        let easy_to_borrow: Bool
        let fractionable: Bool
    }
    
    
}
