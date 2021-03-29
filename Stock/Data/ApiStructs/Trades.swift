//
//  StreamStock.swift
//  Stock
//
//  Created by Андрей Парчуков on 23.03.2021.
//

import Foundation

struct Trades : Codable {
    
    var type: String
    var data: [ActualTrade]
    
    struct ActualTrade: Codable {
        var c: [String]
        var p: Double
        var s: String
        var t: Int64
        var v: Int
    }
    
}
