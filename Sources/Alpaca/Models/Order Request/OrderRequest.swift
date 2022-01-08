//
//  Order+Request.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit




public struct OrderRequest: Codable {
    
    /// symbol, asset ID, or currency pair to identify the asset to trade
    let symbol: String
    let assetClass: AssetClass
    
    /// number of shares to trade. Can be fractionable for only asset and day order types.
    let qty: Double?
    
    /// dollar amount to trade. Cannot work with qty. Can only work for asset order types and day for time in force.
    let notional: Double?
    
    /// buy or sell
    let side: Order.Side
    
    /// asset, limit, stop, stop_limit, or trailing_stop
    let type: Order.OrderType
    
    /// day, gtc, opg, cls, ioc, fok. Please see Understand Orders for more info.
    let time_in_force: Order.TimeInForce
    
    /// required if type is limit or stop_limit
    let limit_price: Double?
    
    let take_profit: Profit?
    
    /// required if type is stop or stop_limit
    let stop_price: Double?
    
    let stop_loss: Loss?
    
    /// this or trail_percent is required if type is trailing_stop
    let trail_price: Double?
    
    /// this or trail_price is required if type is trailing_stop
    let trail_percent: Double?
    
    /// (default) false. If true, order will be eligible to execute in preasset/afterhours. Only works with type limit and time_in_force day.
    let extended_hours: Bool?
    
    /// A unique identifier for the order. Automatically generated if not sent.
    let client_order_id: UUID
    
    /// simple, bracket, oco or oto. For details of non-simple order classes, please see Bracket Order Overview
    let order_class: Order.Class?
    
}




extension OrderRequest: TradeKit.OrderRequest {
    
    
    public var quantity: Double { qty! }
    public var tradeSide: OrderSide {
        switch side {
        case .buy: return .buy
        case .sell: return .sell
        }
    }
    public var tradeType: OrderType {
        switch type {
        case .market: return .market
        case .asset: return .market
        case .limit: return .limit(price: limit_price!)
        case .stop, .trailing_stop: return .stop(price: stop_price!)
        case .stop_limit: return .stopLimit(stop: stop_price!, limit: limit_price!)
        }
    }
    
    
    public init(params: OrderRequestParams) {
        self.symbol = params.asset.symbol
        self.assetClass = params.asset.class
        self.qty = params.quantity
        self.notional = nil
        switch params.tradeSide {
        case .buy: self.side = .buy
        case .sell: self.side = .sell
        }
        self.time_in_force = .day
        self.take_profit = nil
        self.stop_loss = nil
        self.trail_price = nil
        self.trail_percent = nil
//        switch type {
//        case .market:
//            self.type = .market
//            self.limit_price = nil
//            self.stop_price = nil
//            self.extended_hours = false
//
//        case .limit(let price):
            self.type = .limit
        self.limit_price = params.price
            self.stop_price = nil
        self.extended_hours = false //params.asset.class == .market
//
//        case .stop(let price):
//            self.type = .stop
//            self.limit_price = nil
//            self.stop_price = price
//            self.extended_hours = false
//
//        case .stopLimit(let stop, let limit):
//            self.type = .stop_limit
//            self.limit_price = limit
//            self.stop_price = stop
//            self.extended_hours = false
//        }
        self.client_order_id = UUID()
        self.order_class = .simple
    }
    
    
}
