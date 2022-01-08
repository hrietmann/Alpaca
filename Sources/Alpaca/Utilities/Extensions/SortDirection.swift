//
//  SortDirection.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit



extension SortDirection {
    
    var rawValue: String {
        switch self {
        case .ascending: return "asc"
        case .descending: return "desc"
        }
    }
    
}
