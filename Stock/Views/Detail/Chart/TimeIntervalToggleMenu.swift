//
//  RangeItems.swift
//  Stock
//
//  Created by Андрей Парчуков on 26.03.2021.
//

import SwiftUI

struct TimeIntervalToggleMenu: View {
    
    // MARK: - Variables
    
    @Binding var range: DateInterval
    var items: [String] = ["D", "W", "M", "3M", "6M", "Y"]
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(items.indices) { index in
                TimeIntervalButton(title: items[index], active: range.rawValue == index)
                    .onTapGesture {
                        withAnimation {
                            range = DateInterval(rawValue: index) ?? .week
                        }
                    }
            }
        }
    }
}

struct TimeIntervalToggleMenu_Previews: PreviewProvider {
    static var previews: some View {
        TimeIntervalToggleMenu(range: .constant(DateInterval.week))
    }
}
