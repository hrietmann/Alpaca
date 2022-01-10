//
//  Alpaca+h.swift
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
    nonisolated public func historicData(of params: HistoricDataParams) -> AsyncThrowingStream<HistoricDataPage, Error> {
        var isFirstLoad = true
        var pageID: String? = nil
        
        return .init {
            if !isFirstLoad, pageID == nil { return nil }
            
            let api: URL
            let base = URL(string: "https://data.alpaca.markets")!
            switch params.asset.class {
            case .market:
                api = base
                    .appendingPathComponent("v2")
                    .appendingPathComponent("stocks")
            case .crypto:
                api = base
                    .appendingPathComponent("v1beta1")
                    .appendingPathComponent("crypto")
            }
            
            let url = api
                .appendingPathComponent(params.asset.symbol)
                .appendingPathComponent(params.class.urlComponent)
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = [
                .init(name: "start", value: params.start.RFC3339),
                .init(name: "end", value: params.end.RFC3339),
                .init(name: "limit", value: "10000")
            ]
            switch params.class {
            case .candles(let timeframe):
                urlComponents?.queryItems?.append(.init(name: "timeframe", value: timeframe.stringValue))
            default: break
            }
            if params.asset.class == .crypto {
                urlComponents?.queryItems?.append(.init(name: "exchanges", value: Exchange.coinbase.rawValue))
            }
            if let id = pageID { urlComponents?.queryItems?.append(.init(name: "page_token", value: id)) }
            
            guard let url = urlComponents?.url else { throw AlpacaError.invalid(url: urlComponents) }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue(self.publicKey, forHTTPHeaderField: "APCA-API-KEY-ID")
            request.addValue(self.secretKey, forHTTPHeaderField: "APCA-API-SECRET-KEY")
            
            let (data, res) = try await URLSession.shared.data(for: request, delegate: nil)
            if let response = res as? HTTPURLResponse {
                switch response.statusCode {
                case 400: throw AlpacaError(message: "Invalid value for query parameter")
                case 403: throw AlpacaError(message: "Unauthorized")
                case 422: throw AlpacaError(message: "Invalid query parameter")
                case 429: throw AlpacaError(message: "Rate limit exceeded")
                case 400...: throw AlpacaError(message: "Unknown error received from Alpaca")
                default: break
                }
            }
            if let error = try? AlpacaError.from(data: data) { throw error }
            
            let page = try DataPage.from(data: data)
            pageID = page.next_page_token
            isFirstLoad = false
            switch params.class {
            case .candles: return .candles(page.bars ?? [])
            case .trades: return .trades(page.trades ?? [])
            case .quotes: return .quotes(page.quotes ?? [])
            }
        }
    }
    #endif
    
    
}


private extension HistoricDataParams.Class {
    
    var urlComponent: String {
        switch self {
        case .candles: return "bars"
        case .trades: return "trades"
        case .quotes: return "quotes"
        }
    }
    
}


private extension Timeframe {
    
    var stringValue: String {
        switch self {
        case .minute: return "1Min"
        case .minutes(let minutes): return "\(min(abs(minutes), 59))Min"
        case .hour: return "1Hour"
        case .hours(let hours): return "\(min(abs(hours), 23))Hour"
        case .day: return "1Day"
        }
    }
    
}
