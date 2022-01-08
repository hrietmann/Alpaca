//
//  Date.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation





extension Date {
    var RFC3339: String { Formatter.RFC3339.string(from: self) }
    var Alpaca: String { Formatter.Alpaca.string(from: self) }
}
