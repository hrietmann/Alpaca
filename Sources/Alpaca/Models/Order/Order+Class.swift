//
//  Order+Class.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




extension Order {
    
    
    enum Class: String, Codable {
        case simple, bracket, oco, oto
        case none = ""
    }
    
    
}
