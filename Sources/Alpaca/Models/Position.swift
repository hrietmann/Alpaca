//
//  Position.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit




struct Position: Codable, TradeKit.Position {
    
    
    /// Asset ID
    let asset_id: UUID
    
    /// Symbol name of the asset
    let symbol: AssetSymbol
    
    /// Exchange name of the asset (ErisX for crypto)
    let exchange: String
    
    /// Asset class name
    let asset_class: AssetClass
    var order_class: Order.Class! { .init(rawValue: asset_class.rawValue)! }
    
    /// Average entry price of the position
    let avg_entry_price: Number
    public var entryPrice: Double { avg_entry_price.value }
    
    /// The number of shares
    var qty: Number
    var quantity: Double { qty.value }
    
    let side: PositionSide
    
    /// Total dollar amount of the position
    var market_value: Number
    
    /// Total cost basis in dollar
    let cost_basis: Number
    
    /// Unrealized profit/loss in dollars
    var unrealized_pl: Number
    
    /// Unrealized profit/loss percent (by a factor of 1)
    var unrealized_plpc: Number
    
    /// Unrealized profit/loss in dollars for the day
    let unrealized_intraday_pl: Number
    
    /// Unrealized profit/loss percent (by a factor of 1)
    let unrealized_intraday_plpc: Number
    
    /// Current asset price per share
    var current_price: Number
    
    /// Last day’s asset price per share based on the closing value of the last trading day
    let lastday_price: Number
    
    /// Percent change from last day price (by a factor of 1)
    let change_today: Number
    
    
}
