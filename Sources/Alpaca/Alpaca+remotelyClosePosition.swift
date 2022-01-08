//
//  Alpaca+closePosition.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit





extension Alpaca {
    
    
    public func remotelyClose(_ unit: PositionUnit, of position: TradeKit.Position) async throws -> TradeKit.Order {
        let endpoint = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("positions")
            .appendingPathComponent(position.symbol)
        
        let queryItems: [URLQueryItem]
        switch unit {
        case .quantity(let quantity): queryItems = [.init(name: "qty", value: "\(quantity)")]
        case .percentage(let percentage): queryItems = [.init(name: "percentage", value: "\(percentage)")]
        case .all: queryItems = [.init(name: "percentage", value: "\(100)")]
        }
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        let order = try Order.from(data: data)
        return order
    }
    
    
}
