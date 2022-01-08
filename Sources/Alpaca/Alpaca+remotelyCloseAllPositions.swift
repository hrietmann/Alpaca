//
//  Alpaca+closeAllPositions.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit
import CodableKit




extension Alpaca {
    
    
    public func remotelyCloseAllPositions() async throws -> [TradeKit.Order] {
        let url = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("positions")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        
        struct PositionResponse: Codable {
            let status: Int
            let body: Order?
            let symbol: String
        }
        let response = try [PositionResponse].from(data: data)
        return response.compactMap { $0.body }
    }
    
    
}
