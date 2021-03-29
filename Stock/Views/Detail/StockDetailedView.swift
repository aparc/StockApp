//
//  StockDetailedView.swift
//  Stock
//
//  Created by Андрей Парчуков on 26.03.2021.
//

import SwiftUI
import SwiftUICharts

struct StockDetailedView: View {
    
    // MARK: - Variables
    @EnvironmentObject private var stockObserver: StockObserver
    private var ticker: String {
        if let index = stockObserver.selectedStockIndex {
            return self.stockObserver.stocks[index].companyTicker
        } else {
            return ""
        }
    }
    private var companyName: String {
        if let index = stockObserver.selectedStockIndex {
            return self.stockObserver.stocks[index].companyName
        } else {
            return ""
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            NavigationBarDetailedView(ticker: ticker, companyName: companyName)
                .padding([.horizontal, .top], 20)
            
            TabsMenu()
                .frame(height: 40)
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
            Divider()
            ChartView()
            
            Spacer()
        }
        .background(Color.white)
    }
}

struct StockDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailedView()
    }
}
