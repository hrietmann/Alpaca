//
//  DataStream.swift
//  Alpaca
//
//  Created by Hans Rietmann on 19/12/2021.
//

import Foundation
import TradeKit
import LogKit




struct DataStream {
    
    private let assetClass: AssetClass
    private let assets: Set<AssetSymbol>
    private let publicKey: String
    private let secretKey: String
    var stream: AsyncThrowingStream<RealtimeData, Error> {
        .init { continuation in
            Task {
                do {
//                    let socket = WebsocketStream(url: assetClass == .market ? "wss://stream.data.alpaca.markets/v2/sip" : "wss://stream.data.alpaca.markets/v1beta1/crypto?exchanges=\(Exchange.coinbase.rawValue)", on: <#EventLoopGroup#>)
//                    for try await data in socket.stream {
//                        try await handle(data: data, from: socket, continuation: continuation)
//                    }
                    continuation.finish(throwing: nil)
                } catch { continuation.finish(throwing: error) }
            }
        }
    }
    
    init(_ assetClass: AssetClass, assets: Set<AssetSymbol>, publicKey: String, secretKey: String) {
        self.assetClass = assetClass
        self.assets = assets
        self.publicKey = publicKey
        self.secretKey = secretKey
    }
    
    private func handle(data: Data, from socket: WebsocketStream, continuation: AsyncThrowingStream<RealtimeData, Error>.Continuation) async throws {
        if let candles = try await candles(data: data)
        { candles.forEach { continuation.yield($0) } }
        if let quotes = try await quotes(data: data)
        { quotes.forEach { continuation.yield($0) } }
        if let trades = try await trades(data: data)
        { trades.forEach { continuation.yield($0) } }
        
//        try? await [Response].from(data: data).concurrentForEach
//        { try await handle(response: $0, socket: socket, continuation: continuation) }
    }
    
    private func candles(data: Data) async throws -> [RealtimeData]? {
        try? [Bar].from(data: data).lazy
            .filter { (candle: Bar) -> Bool in
                guard let exchange = candle.x else { return true }
                return exchange == .coinbase
            }
            .compactMap { bar -> RealtimeData? in
                guard let symbol = bar.S else { return nil }
                return .candle(bar, symbol)
            }
    }
    
    private func quotes(data: Data) async throws -> [RealtimeData]? {
        try? [Quote].from(data: data).lazy
        .compactMap { quote -> RealtimeData? in
            guard let symbol = quote.S else { return nil }
            return .quote(quote, symbol)
        }
    }
    
    private func trades(data: Data) async throws -> [RealtimeData]? {
        try? [Trade].from(data: data)
            .compactMap { trade -> RealtimeData? in
                guard let symbol = trade.S else { return nil }
                return .trade(trade, symbol)
            }
    }
    
    private func handle(response: Response, socket: WebsocketStream, continuation: AsyncThrowingStream<RealtimeData,Error>.Continuation) async throws {
        switch response.T {
        case .error:
            guard let message = response.msg, let code = response.code else { return }
            continuation.finish(throwing: AlpacaError(message: "Websocket error: \(message) (code \(code))"))
            
        case .success:
//            // Connection succeeded, sending auth request
//            if response.msg == "connected" {
//                var authentication = Message(action: .auth)
//                authentication.key = publicKey
//                authentication.secret = secretKey
//                let data = try authentication.data
//                await socket.send(data)
//            }
//            // Authentication succeeded, sending subscription request
//            if response.msg == "authenticated" {
//                var subscription = Message(action: .subscribe)
//                subscription.trades = assets
//                subscription.quotes = assets
//                subscription.bars = assets
//                subscription.dailyBars = assets
//                let data = try subscription.data
//                await socket.send(data)
//            }
            break
            
        case .subscription:
            let tradeAssets = response.trades ?? []
            let quoteAssets = response.quotes ?? []
            let barAssets = response.bars ?? []
            log(level: .level0, as: .custom("🔔"),
                           "Subscription set:",
                           "trades: \(tradeAssets)",
                           "quotes: \(quoteAssets)",
                           "bars: \(barAssets)")
        }
    }
    
}
