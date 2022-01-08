//
//  Order.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit



public struct Order: Codable, TradeKit.Order {
    
    
    /// Order ID
    public let id: UUID
    
    /// Client unique order ID
    let client_order_id: UUID
    
    let created_at: String
    public var createdAtDate: Date { created_at.Alpaca! }
    
    let updated_at: String?
    
    let submitted_at: String?
    
    private(set) var filled_at: String?
    public var filledAtDate: Date? {
        get { filled_at?.Alpaca }
        set { filled_at = newValue?.Alpaca }
    }
    
    let expired_at: String?
    
    let canceled_at: String?
    
    let failed_at: String?
    
    let replaced_at: String?
    
    /// The order ID that this order was replaced by
    let replaced_by: String?
    
    /// The order ID that this order replaces
    let replaces: String?
    
    /// Asset ID
    let asset_id: UUID?
    
    /// Asset symbol
    public let symbol: AssetSymbol
    
    /// Asset class
    let asset_class: AssetClass
    
    /// Ordered notional amount. If entered, qty will be null. Can take up to 9 decimal points.
    let notional: Number?
    
    /// Ordered quantity. If entered, notional will be null. Can take up to 9 decimal points.
    let qty: Number?
    public var quantity: Double { qty?.value ?? 0 }
    
    /// Filled quantity
    let filled_qty: Number
    
    /// Filled average price
    private(set) var filled_avg_price: Number?
    public var filledAtPrice: Double? {
        get { filled_avg_price?.value }
        set { if let val = newValue { filled_avg_price = .init(val) } }
    }
    
    /// simple, bracket, oco or oto. For details of non-simple order classes, please see
    let order_class: Class
    
    /// Valid values: asset, limit, stop, stop_limit, trailing_stop
    let type: OrderType
    
    let side: Side
    public var orderSide: OrderSide {
        switch side {
        case .buy: return .buy
        case .sell: return .sell
        }
    }
    
    let time_in_force: TimeInForce
    
    /// Limit price
    let limit_price: Number?
    public var limitPrice: Double { limit_price?.value ?? 0 }
    
    /// Stop price
    let stop_price: Number?
    
    private(set) var status: Status
    public var currentStatus: OrderStatus {
        get {
            switch status {
            case .new, .partially_filled, .done_for_day, .replaced, .accepted, .pending_new, .accepted_for_bidding, .calculated, .pending_cancel, .pending_replace:
                return .open
            case .canceled, .expired, .stopped, .rejected, .suspended:
                return .canceled
            case .filled:
                return .closed
            }
        } set {
            switch newValue {
            case .open: status = .new
            case .canceled: status = .canceled
            case .closed: status = .filled
            }
        }
    }
    
    /// If true, eligible for execution outside regular trading hours.
    let extended_hours: Bool
    
    /// When querying non-simple order_class orders in a nested style, an array of Order entities associated with this order. Otherwise, null.
    let legs: [Order]?
    
    /// The percent value away from the high water mark for trailing stop orders.
    let trail_percent: Number?
    
    /// The dollar value away from the high water mark for trailing stop orders.
    let trail_price: Number?
    
    /// The highest (lowest) asset price seen since the trailing stop order was submitted.
    let hwm: Number?
    
    
    public init(dummy request: TradeKit.OrderRequest, at date: Date) {
        let request = request as! OrderRequest
        let limit, stop: Number?
        if let price = request.limit_price { limit = .init(price) } else { limit = nil }
        if let price = request.stop_price { stop = .init(price) } else { stop = nil }
        
        self.id = .init()
        self.client_order_id = .init()
        self.created_at = date.RFC3339
        self.updated_at = nil
        self.submitted_at = nil
        self.filled_at = nil
        self.expired_at = nil
        self.canceled_at = nil
        self.failed_at = nil
        self.replaced_at = nil
        self.replaced_by = nil
        self.replaces = nil
        self.asset_id = nil
        self.symbol = request.symbol
        self.asset_class = request.assetClass
        self.notional = nil
        self.qty = .init(request.quantity)
        self.filled_qty = .init(0)
        self.filled_avg_price = nil
        self.order_class = request.order_class ?? .none
        self.type = request.type
        self.side = request.side
        self.time_in_force = request.time_in_force
        self.limit_price = limit
        self.stop_price = stop
        self.status = .new
        self.extended_hours = request.extended_hours ?? false
        self.legs = nil
        self.trail_percent = nil
        self.trail_price = nil
        self.hwm = nil
    }
    
    
}
