//
//  DataStream+Response.swift
//  Alpaca
//
//  Created by Hans Rietmann on 19/12/2021.
//

import Foundation




extension DataStream {
    
    
    
    struct Response: Codable {
        enum ResponseType: String, Codable {
            case error, success, subscription
        }
        let T: ResponseType
        let msg: String?
        let code: Int?
        let trades: [String]?
        let quotes: [String]?
        let bars: [String]?
    }
    
    
    
}
