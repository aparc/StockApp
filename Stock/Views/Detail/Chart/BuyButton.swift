//
//  SwiftUIView.swift
//  Stock
//
//  Created by Андрей Парчуков on 26.03.2021.
//

import SwiftUI

struct BuyButton: View {
    
    // MARK: - Variables
    var price: Double
    var formattedPrice: String {
        return priceToStringFormat(price: price)
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Buy for \(formattedPrice)")
                .bold()
                .foregroundColor(.white)
        }
        .frame(minWidth: 350, minHeight: 56)
        .background(Color.black)
        .cornerRadius(16)
        
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BuyButton(price: 1637.972)
    }
}
