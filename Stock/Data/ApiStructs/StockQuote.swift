//
//  StockCandleData.swift
//  Stock
//
//  Created by Андрей Парчуков on 22.03.2021.
//

import Foundation

/**
 Class describes actual data for stocks.
 Usually used to represent stock data at the start of application.
 */
struct StockQuote: Codable {
    
    /**
     Initializes a new stock candle with the provided parts and specifications.
     
     - Parameters:
        - o: Open price of the day.
        - h: High price of the day.
        - l: Low price of the day.
        - c: Current price.
        - pc: Previous close price.
     */
    init(o: Double, h: Double, l: Double, c: Double,pc: Double) {
        self.o = o
        self.h = h
        self.l = h
        self.c = c
        self.pc = pc
    }

    var o: Double
    var h: Double
    var l: Double
    var c: Double
    var pc: Double
    
    func convertToStock(_ ticker: String, _ companyName: String) -> Stock {
        return Stock(ticker: ticker, name: companyName, price: c, previousClosePrice: pc)
    }
    
}
