//
//  Calendar.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation







extension Calendar {
    
    
    static let GMT0: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    
}
