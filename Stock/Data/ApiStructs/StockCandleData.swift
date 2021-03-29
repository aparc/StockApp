//
//  StockCandleData.swift
//  Stock
//
//  Created by Андрей Парчуков on 22.03.2021.
//

import Foundation

/**
 Class describes candlestick data for stocks.
 Usually used to represent stock data at the start of application.
 */
struct StockCandleData: Codable {
    
    /**
     Initializes a new stock candle with the provided parts and specifications.
     
     - Parameters:
        - o: List of open prices for returned candles.
        - h: List of high prices for returned candles.
        - l: List of low prices for returned candles.
        - c: List of close prices for returned candles.
        - v: List of volume data for returned candles.
        - t: List of timestamp for returned candles.
        - s: Status of the response. This field can either be ok or no_data.
     */
    init(o: [Double], h: [Double], l: [Double], c: [Double], v: [Int], t: [Int64], s: String) {
        self.o = o
        self.h = h
        self.l = h
        self.c = c
        self.v = v
        self.t = t
        self.s = s
    }

    var o: [Double]
    var h: [Double]
    var l: [Double]
    var c: [Double]
    var v: [Int]
    var t: [Int64]
    var s: String
    
}
