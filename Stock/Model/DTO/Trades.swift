//
//  StreamStock.swift
//  Stock
//
//  Created by Андрей Парчуков on 23.03.2021.
//

import Foundation

/// Stream real-time trades for stocks getting via websocket from external API.
struct Trades : Codable {

    /// message type
    var type: String
    /// List of trades or price updates
    var data: [TradeData]

    struct TradeData: Codable {
        
        init(c: [String], p: Double, s: String, t: Int64, v: Int) {
            self.c = c
            self.p = p
            self.s = s
            self.t = t
            self.v = v
        }
        
        /// List of trade conditions
        var c: [String]
        /// Last price
        var p: Double
        /// Ticker
        var s: String
        /// UNIX milliseconds timestamp.
        var t: Int64
        /// Volume
        var v: Int
    }

}
