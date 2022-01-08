//
//  Environment.swift
//  Alpaca
//
//  Created by Hans Rietmann on 01/12/2021.
//

import Foundation
import TradeKit




extension Environment {
    
    
    var historicDataURL: URL {
        .init(string: "https://data.alpaca.markets")!
    }
    var privateAPIURL: URL {
        let domain = isPaper || isBacktest ? "paper-api.alpaca.markets":"api.alpaca.markets"
        let rootURL = "https://" + domain
        return URL(string: rootURL)!
    }
    
    
}
