//
//  Stock.swift
//  Stock
//
//  Created by Андрей Парчуков on 22.03.2021.
//

import Foundation

struct Stock {
    
    init(ticker: String, name: String, price: Double, previousClosePrice: Double) {
        self.companyTicker = ticker
        self.companyName = name
        self.currentPrice = price
        self.previousClosePrice = previousClosePrice
        self.calculateChanges()
    }
    
    var companyTicker: String
    var companyName: String
    var isFavourite: Bool = false
    var currentPrice: Double = 0.0
    var previousClosePrice: Double = 0.0
    var priceChange: Double = 0.0
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
