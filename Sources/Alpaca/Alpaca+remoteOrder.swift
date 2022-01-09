//
//  Alpaca+order.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif



extension Alpaca {
    
    
    public func remoteOrder(_ id: UUID) async throws -> TradeKit.Order? {
        
        // Fetching order with the same id as the given id
        let endpoint = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("orders")
        var components = URLComponents(url: endpoint.appendingPathComponent(id.uuidString), resolvingAgainstBaseURL: true)
        components?.queryItems = [.init(name: "nested", value: "true")]
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        guard let res = response as? HTTPURLResponse, res.statusCode == 404 else {
            if let error = try? AlpacaError.from(data: data) { throw error }
            let order = try Order.from(data: data)
            return order
        }
        
        // Fetching order with the same client id as the given id
        components?.queryItems = [.init(name: "client_order_id", value: id.uuidString)]
        guard let url = components?.url else { throw AlpacaError.invalid(url: components) }
        request = URLRequest(url: url)
        request.httpMethod = "GET"
        setHeader(to: &request)
        
        let (data2, response2) = try await URLSession.shared.data(for: request, delegate: nil)
        if let res = response2 as? HTTPURLResponse, res.statusCode == 404 { return nil }
        if let error = try? AlpacaError.from(data: data2) { throw error }
        let order = try Order.from(data: data2)
        return order
    }
    
    
}
