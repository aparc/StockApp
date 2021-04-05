//
//  RangeButton.swift
//  Stock
//
//  Created by Андрей Парчуков on 26.03.2021.
//

import SwiftUI

struct TimeIntervalButton: View {
    
    var title: String
    var active: Bool
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundColor(active ? .white : .black)
            .padding()
            .frame(minWidth: 40, minHeight: 40)
            .background(active ? Color.black : Color.init("odd"))
            .cornerRadius(12)
    }
}

struct TimeIntervalButton_Previews: PreviewProvider {
    static var previews: some View {
        TimeIntervalButton(title: "D", active: true)
    }
}
