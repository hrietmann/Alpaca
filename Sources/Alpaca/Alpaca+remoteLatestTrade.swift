//
//  Alpaca+latestTrade.swift
//  Alpaca
//
//  Created by Hans Rietmann on 01/12/2021.
//

import Foundation
import TradeKit
import CodableKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
#if compiler(>=5.5) && canImport(_Concurrency)
import _Concurrency
#endif



extension Alpaca {
    
    
    #if compiler(>=5.5) && canImport(_Concurrency) && canImport(FoundationNetworking)
    public func remoteLatestTrade(of asset: TradeKit.Asset) async throws -> TradeKit.Trade {
        let endpoint: URL
        switch asset.class {
        case .market:
            endpoint = environment.historicDataURL
                .appendingPathComponent("v2")
                .appendingPathComponent("stocks")
        case .crypto:
            endpoint = environment.historicDataURL
                .appendingPathComponent("v1beta1")
                .appendingPathComponent("crypto")
        }
        let tradeURL = endpoint
            .appendingPathComponent(asset.symbol)
            .appendingPathComponent("trades")
            .appendingPathComponent("latest")
        var components = URLComponents(url: tradeURL, resolvingAgainstBaseURL: true)
        if asset.class == .crypto {
            components?.queryItems = [.init(name: "exchange", value: Exchange.coinbase.rawValue)]
        }
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        let trade = try Trade.Latest.from(data: data).trade
        return trade
    }
    #endif
    
    
}
