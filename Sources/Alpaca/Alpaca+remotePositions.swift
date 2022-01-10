//
//  Alpaca+positions.swift
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
    public var remotePositions: [TradeKit.Position] {
        get async throws {
            let url = environment.privateAPIURL
                .appendingPathComponent("v2")
                .appendingPathComponent("positions")
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            setHeader(to: &request)
            
            let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
            if let error = try? AlpacaError.from(data: data) { throw error }
            let positions = try [Position].from(data: data, debug: true)
            return positions
        }
    }
    #endif
    
    
}
