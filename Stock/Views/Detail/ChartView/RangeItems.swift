//
//  RangeItems.swift
//  Stock
//
//  Created by Андрей Парчуков on 26.03.2021.
//

import SwiftUI

struct RangeItems: View {
    
    // MARK: - Variables
    @Binding var range: StockDateRange
    var items: [String] = ["D", "W", "M", "3M", "6M", "Y"]
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(items.indices) { index in
                RangeButton(title: items[index], active: range.rawValue == index)
                    .onTapGesture {
                        withAnimation {
                            range = StockDateRange(rawValue: index) ?? .week
                        }
                    }
            }
        }
    }
}

struct RangeItems_Previews: PreviewProvider {
    static var previews: some View {
        RangeItems(range: .constant(StockDateRange.week))
    }
}
