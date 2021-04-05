//
//  Baloon.swift
//  Stock
//
//  Created by Андрей Парчуков on 29.03.2021.
//

import SwiftUI

struct Baloon: View {
    
    var date: Int64
    var price: Double
    var formattedPrice: String {
        return priceToStringFormat(price: price)
    }
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "d MMM yyyy, hh:mm"
        return formatter.string(from: Date(timeIntervalSince1970: Double(date)))
    }
    
    var body: some View {
        VStack {
            Text(formattedPrice)
                .foregroundColor(.white)
                .font(.caption)
                .bold()
            Text(formattedDate)
                .foregroundColor(.gray)
                .font(.caption2)
                .bold()
        }
        .padding(10)
        .background(Color.black)
        .cornerRadius(16)
        .shadow(radius: 10)
        .rotation3DEffect(
            .degrees(180),
            axis: (x: 1.0, y: 0.0, z: 0.0))
    }
}

struct Baloon_Previews: PreviewProvider {
    static var previews: some View {
        Baloon(date: 1615302599, price: 252.12)
    }
}
