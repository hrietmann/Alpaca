//
//  Alpaca+orders.swift
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



extension Alpaca {
    
    
    public func remoteOrders(_ status: Set<OrderStatus>, sorted by: SortDirection) async throws -> [TradeKit.Order] {
        let endpoint = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("orders")
        
        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            .init(name: "limit", value: "500"),
            .init(name: "direction", value: by.rawValue),
            .init(name: "nested", value: "true")
        ]
        let statusValue: String
        if let status = status.first { statusValue = status.rawValue }
        else { statusValue = "all" }
        components?.queryItems?.append(.init(name: "status", value: statusValue))
        
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        let orders = try [Order].from(data: data)
        return orders
    }
    
    
}

