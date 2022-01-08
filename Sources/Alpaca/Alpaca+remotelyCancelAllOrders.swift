//
//  Alpaca+cancelAllOrders.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation





extension Alpaca {
    
    
    public func remotelyCancelAllOrders() async throws {
        let url = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("orders")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        setHeader(to: &request)
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
    }
    
    
}
