//
//  Exchange.swift
//  Alpaca
//
//  Created by Hans Rietmann on 30/11/2021.
//

import Foundation




enum Exchange: String, Codable {
    
    
    
    case erisX = "ERSX"
    case genesis = "Genesis"
    case coinbase = "CBSE"
    case ftx = "FTX"
    
    
    /// NYSE American (AMEX)
    case amex = "A"
    case amex_full = "AMEX"
    case bats = "BATS"
    /// NASDAQ OMX BX
    case nasdaq = "B"
    case nasdaq_full = "NASDAQ"
    /// National Stock Exchange
    case nationalExchange = "C"
    /// FINRA ADF
    case finra = "D"
    /// Market Independent
    case marketIndendant = "E"
    /// MIAX
    case miax = "H"
    /// International Securities Exchange
    case international = "I"
    /// Cboe EDGA
    case edga = "J"
    /// Cboe EDGX
    case edgx = "K"
    /// Long Term Stock Exchange
    case ltse = "L"
    /// Chicago Stock Exchange
    case chicago = "M"
    /// New York Stock Exchange
    case nyse = "N"
    case nyse_full = "NYSE"
    /// NYSE Arca
    case arca = "P"
    case arca_full = "ARCA"
    case nyse_arca = "NYSEARCA"
    /// NASDAQ OMX
    case omx = "Q"
    /// NASDAQ Small Cap
    case smallCap = "S"
    /// NASDAQ Int
    case int = "T"
    /// Members Exchange
    case membersExchange = "U"
    /// IEX
    case iex = "V"
    /// CBOE
    case cboe = "W"
    /// NASDAQ OMX PSX
    case omxpsx = "X"
    /// Cboe BYX
    case cboebyx = "Y"
    /// Cboe BZX
    case bzx = "Z"
    
    
    public var isCrypto: Bool {
        switch self {
        case .erisX, .genesis, .coinbase: return true
        default: return false
        }
    }
    
    
}
