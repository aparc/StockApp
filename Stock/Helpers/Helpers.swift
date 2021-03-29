//
//  Helpers.swift
//  Stock
//
//  Created by Андрей Парчуков on 28.03.2021.
//

import Foundation
import SwiftUI


func priceToStringFormat(price: Double) -> String {
    let formatter = NumberFormatter()
    formatter.currencyGroupingSeparator = " "
    formatter.currencySymbol = "$"
    formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: price)) ?? "0.00"
}

func percentPriceChangeToStringFormat(percentChange: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter.string(from: NSNumber(value: percentChange)) ?? "0.00%"
}

func priceChangeToStringFormat(priceChange: Double, percentChange: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    let regularChange = formatter.string(from: NSNumber(value: priceChange)) ?? "0.00"
    return "\(regularChange) (\(percentPriceChangeToStringFormat(percentChange: percentChange)))"
}

func daysAgo(days: Int) -> TimeInterval {
    var components = DateComponents()
    components.day = -days
    return Calendar.utcCalendar.date(byAdding: components, to: Date())!.timeIntervalSince1970
}

func yearAgo() -> TimeInterval {
    var components = DateComponents()
    components.year = -1
    return Calendar.utcCalendar.date(byAdding: components, to: Date())!.timeIntervalSince1970
}

func monthsAgo(months: Int) -> TimeInterval {
    var components = DateComponents()
    components.month = -months
    return Calendar.utcCalendar.date(byAdding: components, to: Date())!.timeIntervalSince1970
}

extension TimeInterval {
    
    func dropDecimal() -> Int {
        return Int(self)
    }
    
}

extension Calendar {
    
    public static var utcCalendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }
    
}


extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
