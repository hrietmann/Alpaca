//
//  Alpaca+orderRequest.swift
//  Alpaca
//
//  Created by Hans Rietmann on 02/12/2021.
//

import Foundation
import TradeKit
import CodableKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif



extension Alpaca {
    
    
    #if compiler(>=5.5) && canImport(_Concurrency)
    public func remotelyOrder(_ request: OrderRequestParams) async throws -> TradeKit.Order {
        let url = environment.privateAPIURL
            .appendingPathComponent("v2")
            .appendingPathComponent("orders")
        let body = try OrderRequest(params: request).data
        print(body.prettyJSON)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        setHeader(to: &request)
        request.httpBody = body
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        if let error = try? AlpacaError.from(data: data) { throw error }
        let order = try Order.from(data: data)
        return order
    }
    #endif
    
    
}
