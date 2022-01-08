//
//  Account.swift
//  Alpaca
//
//  Created by Hans Rietmann on 07/11/2021.
//

import Foundation
import TradeKit




struct Account: Codable, TradeKit.Account {
    
    
    /// Account ID.
    let id: UUID
    
    /// Account number.
    let account_number: String
    
    /// See Account Status
    let status: Status
    let currency: String
    
    let crypto_status: CryptoStatus
    
    /// Cash balance
    let cash: Number
    var totalCash: Double { cash.value }
    
    /// Total value of cash + holding positions (This field is deprecated. It is equivalent to the equity field.)
    let portfolio_value: Number
    
    /// Whether or not the account has been flagged as a pattern day trader
    let pattern_day_trader: Bool
    
    /// User setting. If true, the account is not allowed to place orders.
    let trade_suspended_by_user: Bool
    
    /// If true, the account is not allowed to place orders.
    let trading_blocked: Bool
    
    /// If true, the account is not allowed to request money transfers.
    let transfers_blocked: Bool
    
    /// If true, the account activity by user is prohibited.
    let account_blocked: Bool
    
    /// Timestamp this account was created at
    let created_at: String
    
    /// Flag to denote whether or not the account is permitted to short
    let shorting_enabled: Bool // true
    
    /// Real-time MtM value of all long positions held in the account
    let long_market_value: Number
    
    /// Real-time MtM value of all short positions held in the account
    let short_market_value: Number
    
    /// Cash + long_market_value + short_market_value
    let equity: Number
    public var totalEquity: Double { equity.value }
    
    /// Equity as of previous trading day at 16:00:00 ET
    let last_equity: Number
    
    /// Buying power multiplier that represents account margin classification; valid values 1 (standard limited margin account with 1x buying power), 2 (reg T margin account with 2x intraday and overnight buying power; this is the default for all non-PDT accounts with $2,000 or more equity), 4 (PDT account with 4x intraday buying power and 2x reg T overnight buying power)
    let multiplier: Number
    
    /// Current available $ buying power; If multiplier = 4, this is your daytrade buying power which is calculated as (last_equity - (last) maintenance_margin) * 4; If multiplier = 2, buying_power = max(equity – initial_margin,0) * 2; If multiplier = 1, buying_power = cash
    let buying_power: Number
    var buyingPower: Double { buying_power.value }
    
    /// Reg T initial margin requirement (continuously updated value)
    let initial_margin: Number
    
    /// Maintenance margin requirement (continuously updated value)
    let maintenance_margin: Number
    
    /// Value of special memorandum account (will be used at a later date to provide additional buying_power)
    let sma: Number?
    
    /// The current number of daytrades that have been made in the last 5 trading days (inclusive of today)
    let daytrade_count: Number
    
    /// Your maintenance margin requirement on the previous trading day
    let last_maintenance_margin: Number
    
    /// Your buying power for day trades (continuously updated value)
    let daytrading_buying_power: Number
    
    /// Your buying power under Regulation T (your excess equity - equity minus margin value - times your margin multiplier)
    let regt_buying_power: Number
    
    
    public init(cash: Double) {
        self.id = UUID()
        self.account_number = "account_number"
        self.status = .APPROVED
        self.currency = "USD"
        self.crypto_status = .ACTIVE
        self.cash = .init(cash)
        self.portfolio_value = .init(0)
        self.pattern_day_trader = false
        self.trade_suspended_by_user = false
        self.trading_blocked = false
        self.transfers_blocked = false
        self.account_blocked = false
        self.created_at = Date().RFC3339
        self.shorting_enabled = true
        self.long_market_value = Number(0)
        self.short_market_value = Number(0)
        self.equity = .init(cash)
        self.last_equity = .init(0)
        self.multiplier = Number(2)
        self.buying_power = Number(cash * 2)
        self.initial_margin = Number(0)
        self.maintenance_margin = Number(0)
        self.sma = nil
        self.daytrade_count = Number(0)
        self.last_maintenance_margin = Number(0)
        self.daytrading_buying_power = Number(0)
        self.regt_buying_power = Number(0)
    }
    
}
