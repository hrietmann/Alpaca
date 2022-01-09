//
//  Alpaca+asset.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
#if compiler(>=5.5) && canImport(_Concurrency)
import _Concurrency
#endif




extension Alpaca {
    
    
    #if compiler(>=5.5) && canImport(_Concurrency)
    public func remoteAsset(from symbol: AssetSymbol) async throws -> TradeKit.Asset? {
        let url = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("assets")
            .appendingPathComponent(symbol)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        if let res = response as? HTTPURLResponse, res.statusCode == 404 { return nil }
        if let error = try? AlpacaError.from(data: data) { throw error }
        let asset = try Market.from(data: data)
        return asset
    }
    #endif
    
    
}
