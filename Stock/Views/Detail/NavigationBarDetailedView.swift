//
//  NavigationBarDetailedView.swift
//  Stock
//
//  Created by Андрей Парчуков on 25.03.2021.
//

import SwiftUI

struct NavigationBarDetailedView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var stockObserver: StockObserver
    var ticker: String
    var companyName: String
    var isFavourite: Bool {
        if let index = stockObserver.selectedStockIndex {
            return stockObserver.stocks[index].isFavourite
        } else {
            return false
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Button(action: onBackClick) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
            }
            Spacer()
            VStack {
                Text(ticker)
                    .bold()
                    .font(.title3)
                Text(companyName)
            }
            Spacer()
            Button(action: onFavouriteClick) {
                Image(isFavourite ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
    
    // MARK: - Functions
    
    func onFavouriteClick() {
        stockObserver.stocks[stockObserver.selectedStockIndex!].isFavourite.toggle()
    }
    
    func onBackClick() {
        self.stockObserver.selectedStockIndex = nil
        self.stockObserver.prices = [StockTimePrice]()
    }
    
}

// MARK: - Preview
struct NavigationBarDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarDetailedView(ticker: "AAPL", companyName: "Apple Inc.")
    }
}
