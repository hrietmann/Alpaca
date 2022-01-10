//
//  Alpaca.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import TradeKit




public actor Alpaca: Broker {
    
    
    let publicKey: String
    let secretKey: String
    public let fees: TradeKit.Fees = Fees()
    public let environment: Environment
    public let maxHistoricDataPageItems: Int = 10_000
    
    
    public static func backtest(cash: Double = 100_000) throws -> Alpaca {
        guard let paperPublicKey = ProcessInfo.processInfo.environment["ALPACA_PAPER_PUBLIC_KEY"]
        else { throw AlpacaError(message: "ALPACA_PAPER_PUBLIC_KEY is missing from Xcode environment arguments.") }
        guard let paperPrivateKey = ProcessInfo.processInfo.environment["ALPACA_PAPER_PRIVATE_KEY"]
        else { throw AlpacaError(message: "ALPACA_PAPER_PRIVATE_KEY is missing from Xcode environment arguments.") }
        return .init(.backtest(cash: cash, paperPublicKey: paperPublicKey, paperSecretKey: paperPrivateKey))
    }
    
    public static var paper: Alpaca {
        get throws {
            guard let paperPublicKey = ProcessInfo.processInfo.environment["ALPACA_PAPER_PUBLIC_KEY"]
            else { throw AlpacaError(message: "ALPACA_PAPER_PUBLIC_KEY is missing from Xcode environment arguments.") }
            guard let paperPrivateKey = ProcessInfo.processInfo.environment["ALPACA_PAPER_PRIVATE_KEY"]
            else { throw AlpacaError(message: "ALPACA_PAPER_PRIVATE_KEY is missing from Xcode environment arguments.") }
            return .init(.paper(publicKey: paperPublicKey, secretKey: paperPrivateKey))
        }
    }
    
    public static var production: Alpaca {
        get throws {
            guard let productionPublicKey = ProcessInfo.processInfo.environment["ALPACA_PRODUCTION_PUBLIC_KEY"]
            else { throw AlpacaError(message: "ALPACA_PRODUCTION_PUBLIC_KEY is missing from Xcode environment arguments.") }
            guard let productionPrivateKey = ProcessInfo.processInfo.environment["ALPACA_PRODUCTION_PRIVATE_KEY"]
            else { throw AlpacaError(message: "ALPACA_PRODUCTION_PRIVATE_KEY is missing from Xcode environment arguments.") }
            return .init(.production(publicKey: productionPublicKey, secretKey: productionPrivateKey))
        }
    }
    
    public init(_ env: Environment) {
        switch env {
        case .backtest(_, let publicKey, let secretKey):
            self.publicKey = publicKey
            self.secretKey = secretKey
        case .paper(let publicKey, let secretKey):
            self.publicKey = publicKey
            self.secretKey = secretKey
        case .production(let publicKey, let secretKey):
            self.publicKey = publicKey
            self.secretKey = secretKey
        }
        environment = env
    }
    
//    #if canImport(FoundationNetworking)
    func setHeader(to request: inout URLRequest) {
        request.addValue(publicKey, forHTTPHeaderField: "APCA-API-KEY-ID")
        request.addValue(secretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
    }
//    #endif
    
    nonisolated public func sampleAccount(cash: Double) -> TradeKit.Account {
        Account(cash: cash)
    }
    
    nonisolated public func sampleOrder(from request: OrderRequestParams, at date: Date) -> TradeKit.Order {
        Order(dummy: OrderRequest(params: request), at: date)
    }
    
    
}
