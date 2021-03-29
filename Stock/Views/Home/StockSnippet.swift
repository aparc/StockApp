//
//  SwiftUIView.swift
//  Stock
//
//  Created by Андрей Парчуков on 14.03.2021.
//

import SwiftUI

struct StockSnippet: View {
    
    // MARK: - Variables
    var stock: Stock
    var backgroundColor: Color
    var price: String {
        return priceToStringFormat(price: stock.currentPrice)
    }
    var priceChanges: String {
        return priceChangeToStringFormat(priceChange: stock.priceChange, percentChange: stock.pricePercentChange)
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(stock.companyTicker)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                HStack {
                    Text(stock.companyTicker)
                        .font(.title3)
                        .bold()
                    Image(stock.isFavourite ? "star.fill" : "star")
                    Spacer()
                    Text(price)
                        .font(.title3)
                        .bold()
                }
                HStack {
                    Text(stock.companyName)
                        .font(.footnote)
                    Spacer()
                    Text(priceChanges)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(stock.priceChange >= 0 ? .green : .red)
                }
            }
        }
        .padding(10)
        .frame(height: 70, alignment: .center)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}

struct Snippet_Previews: PreviewProvider {
    static var previews: some View {
        StockSnippet(stock: Stock(ticker: "AAPL", name: "Apple Inc.", price: 625.56, previousClosePrice: 521.65), backgroundColor: Color.init("odd"))
    }
}
