//
//  Stock.swift
//  Stock
//
//  Created by Андрей Парчуков on 22.03.2021.
//

import Foundation

/// Сontains information about the current price, price changes and which company belongs to
struct Stock {
    
    /// Initializes a new stock with the provided parts and specifications.
    /// - Parameters:
    ///   - ticker: Company ticker (e.g. `"AAPL"`)
    ///   - name: Company name
    ///   - price: Current price
    ///   - previousClosePrice: Price that was at the close of trading
    init(ticker: String, name: String, price: Double, previousClosePrice: Double) {
        self.companyTicker = ticker
        self.companyName = name
        self.currentPrice = price
        self.previousClosePrice = previousClosePrice
        self.calculateChanges()
    }
    
    /// Company ticker (e.g. `"AAPL"`)
    var companyTicker: String
    
    /// Company name
    var companyName: String
    
    /// Mark if current stock should be visible in favourites stock list
    var isFavourite: Bool = false
    
    /// Current stock price
    var currentPrice: Double = 0.0
    
    /// Price that was at the close of trading
    var previousClosePrice: Double = 0.0
    
    /// Change in the current price from the price at the close of trading
    var priceChange: Double = 0.0
    
    /// Percentage change in the current price from the price at the close of trading
    var pricePercentChange: Double = 0.0
    
    mutating func calculateChanges() {
        self.priceChange = self.currentPrice - self.previousClosePrice
        self.pricePercentChange = self.calculatePercentageDifference(originalPrice: self.previousClosePrice, actualPrice: self.currentPrice)
    }
    
    private func calculatePercentageDifference(originalPrice: Double, actualPrice: Double) -> Double {
        if originalPrice > actualPrice {
               return ((originalPrice - actualPrice)/originalPrice)
        } else if originalPrice < actualPrice {
            return ((actualPrice - originalPrice)/originalPrice)
        } else {
            return originalPrice
        }
    }
    
}
