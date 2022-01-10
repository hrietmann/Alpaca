//
//  AccountStream.swift
//  Alpaca
//
//  Created by Hans Rietmann on 19/12/2021.
//

import Foundation
import TradeKit
#if compiler(>=5.5) && canImport(_Concurrency)
import _Concurrency
#endif






#if compiler(>=5.5) && canImport(_Concurrency)
struct AccountStream {
    
    
    let environment: TradeKit.Environment
    private let publicKey: String
    private let secretKey: String
    
    var stream: AsyncThrowingStream<RealtimeData,Error> {
        .init { continuation in
            Task {
//                do {
//                    let url = "wss://\(environment.isPaper ? "paper-":"")api.alpaca.markets/stream"
//                    let socket = WebsocketStream(url: url) { stream in
//                        var body = Body()
//                        body.key_id = publicKey
//                        body.secret_key = secretKey
//                        let message = Message(action: .authenticate, data: body)
//                        let data = try JSONEncoder().encode(message)
//                        await stream.send(data)
//                    }
//
//
//                    for try await data in socket.stream {
//                        try await handle(data: data, from: socket, continuation: continuation)
//                    }
//                } catch { continuation.finish(throwing: error) }
            }
        }
    }
    
    init(environment: TradeKit.Environment, publicKey: String, secretKey: String) {
        self.environment = environment
        self.publicKey = publicKey
        self.secretKey = secretKey
    }
    
    private func handle(data: Data, from stream: WebsocketStream, continuation: AsyncThrowingStream<RealtimeData, Error>.Continuation) async throws {
        
        let response = try Response.from(data: data, debug: true)
        switch response.stream {
        case .authorization:
//            var body = Body()
//            body.streams = [.trade_updates]
//            let message = Message(action: .listen, data: body)
//            let data = try JSONEncoder().encode(message)
//            await stream.send(data)
            break
            
        case .listening:
            break
            
        case .trade_updates:
            guard let order = response.data.order else { return }
            continuation.yield(.order(order))
        }
    }
    
    enum Action: String, Codable {
        case listen, authenticate
    }
    
    enum Stream: String, Codable {
        case trade_updates, listening, authorization
    }
    
    enum Status: String, Codable {
        case authorized, unauthorized
    }
    
    struct Body: Codable {
        var streams: Set<Stream>? = nil
        var key_id: String? = nil
        var secret_key: String? = nil
        let timestamp: String?
        let status: Status?
        let execution_id: UUID?
        let order: Order?
        
        init() {
            timestamp = nil
            status = nil
            execution_id = nil
            order = nil
        }
    }
    
    struct Message: Codable {
        let action: Action
        let data: Body
    }
    
    struct Response: Codable {
        let stream: Stream
        let data: Body
    }
    
    
}
#endif
