//
//  Error.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




struct AlpacaError: LocalizedError, Codable {
    
    let message: String
    var errorDescription: String? { message }
    
    
    static let publicKeyMissing = AlpacaError(message: "Unable to send the request to Alpaca because public key is missing. Make sure to configure Alpaca using configure method.")
    static let secretKeyMissing = AlpacaError(message: "Unable to send the request to Alpaca because secret key is missing. Make sure to configure Alpaca using configure method.")
    
    static func notFount(_ details: String? = nil) -> AlpacaError { .init(message: "Not found. \(details ?? "No details.")")}
    static func invalid(url: URL) -> AlpacaError { .init(message: "URL is invalid: \(url.absoluteString)") }
    static func invalid(url components: URLComponents?) -> AlpacaError { .init(message: "URL is invalid: \(components ?? URLComponents())") }
    
}
