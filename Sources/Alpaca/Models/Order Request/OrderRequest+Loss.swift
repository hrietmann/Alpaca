//
//  OrderRequest+Loss.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




extension OrderRequest {
    
    
    struct Loss: Codable {
        
        let stop_price: Double
        let limit_price: Double
        
    }
    
    
}
