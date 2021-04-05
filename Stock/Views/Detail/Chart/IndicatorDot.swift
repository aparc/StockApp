//
//  IndicatorDot.swift
//  Stock
//
//  Created by Андрей Парчуков on 29.03.2021.
//

import SwiftUI

struct IndicatorDot: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.black)
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
        .shadow(radius: 10)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorDot()
    }
}
