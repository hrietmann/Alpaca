//
//  Alpaca+asset.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit





extension Alpaca {
    
    
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
    
    
}
