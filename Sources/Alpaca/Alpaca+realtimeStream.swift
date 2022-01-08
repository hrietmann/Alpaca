//
//  Alpaca+realTimeUpdatesStream.swift
//  Alpaca
//
//  Created by Hans Rietmann on 19/12/2021.
//

import Foundation
import TradeKit
import LogKit




extension Alpaca {
    
    
    
    nonisolated public func realtimeStream(for assets: [Asset]) -> AsyncThrowingStream<RealtimeData, Error> {
        .init { continuation in
            Task {
                do {
                    var streams: [AsyncThrowingStream<RealtimeData,Error>] = assets.lazy
                        .reduce(into: [AssetClass:[AssetSymbol]]()) { $0[$1.class] = ($0[$1.class] ?? []) + [$1.symbol] }
                        .map { DataStream($0.key, assets: .init($0.value), publicKey: publicKey, secretKey: secretKey) }
                        .map { $0.stream }
                    streams.append(AccountStream(environment: environment, publicKey: publicKey, secretKey: secretKey).stream)
                    
                    try await streams.concurrentForEach { stream in
                        for try await result in stream {
                            continuation.yield(result)
                        }
                    }
                    continuation.finish(throwing: nil)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            
        }
    }
    
    
    
}
