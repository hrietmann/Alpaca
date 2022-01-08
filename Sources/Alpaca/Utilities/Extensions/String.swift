//
//  String.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation



extension String {
    var RFC3339: Date? { Formatter.RFC3339.date(from: self) }
    var Alpaca: Date? { Formatter.Alpaca.date(from: self) }
}
