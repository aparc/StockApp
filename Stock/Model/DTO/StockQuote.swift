//
//  StockCandleData.swift
//  Stock
//
//  Created by Андрей Парчуков on 22.03.2021.
//

import Foundation

/// Class describes actual data for stocks getting from external API. Usually used to represent stock data at the start of application.
struct StockQuote: Codable {
    
    /// Initializes a new quote with the provided parts and specifications.
    /// - Parameters:
    ///   - o: Open price of the day
    ///   - h: High price of the day
    ///   - l: Low price of the day
    ///   - c: Current price
    ///   - pc: Previous close price
    init(o: Double, h: Double, l: Double, c: Double,pc: Double) {
        self.o = o
        self.h = h
        self.l = h
        self.c = c
        self.pc = pc
    }

    /// Open price of the day
    var o: Double
    /// High price of the day
    var h: Double
    /// Low price of the day
    var l: Double
    /// Current price
    var c: Double
    /// Previous close price
    var pc: Double
    
    func convertToStock(_ ticker: String, _ companyName: String) -> Stock {
        return Stock(ticker: ticker, name: companyName, price: c, previousClosePrice: pc)
    }
    
}
