//
//  Formatter.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation



extension Formatter {
    
    static var RFC3339: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }
    
    public static var Alpaca: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
}
