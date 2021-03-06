//
//  Alpaca+latestQuote.swift
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
    
    
    
//#if compiler(>=5.5) && canImport(_Concurrency) && canImport(FoundationNetworking)
    public func remoteLatestQuote(of asset: TradeKit.Asset) async throws -> TradeKit.Quote {
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
        let quoteURL = endpoint
            .appendingPathComponent(asset.symbol)
            .appendingPathComponent("quotes")
            .appendingPathComponent("latest")
        var components = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        if asset.class == .crypto {
            components?.queryItems = [.init(name: "exchange", value: Exchange.coinbase.rawValue)]
        }
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        let quote = try Quote.Latest.from(data: data).quote
        return quote
    }
//    #else
//    public func remoteLatestQuote(of asset: TradeKit.Asset) async throws -> TradeKit.Quote {
//        let n = Number(0)
//        return Quote(S: nil, x: nil, ax: nil, ap: n, as: n, bx: nil, bp: n, bs: n, t: "", c: nil, z: nil)
//    }
//#endif
    
    
    
}
