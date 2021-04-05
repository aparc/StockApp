//
//  ChartData.swift
//
//
//  Created by Андрей Парчуков on 29.03.2021.
//

import Foundation
import SwiftUI


public class ChartData: Identifiable {
    var points: [(Int64, Double)]
    var ID = UUID()
    
    init(values: [StockTimePrice]) {
        self.points = values.map { ($0.time, $0.price) }
    }
    
    public func onlyPoints() -> [Double] {
        return self.points.map { $0.1 }
    }
}
