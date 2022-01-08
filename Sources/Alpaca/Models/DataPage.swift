//
//  DataPage.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




struct DataPage: Codable {
    let bars: [Bar]?
    let trades: [Trade]?
    let quotes: [Quote]?
    let symbol: String
    let next_page_token: String?
}
