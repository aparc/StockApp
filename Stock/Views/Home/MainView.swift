//
//  ContentView.swift
//  Stock
//
//  Created by Андрей Парчуков on 14.03.2021.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var stockObserver: StockObserver
    @State private var searchText: String = ""
    @State private var showFavourites: Bool = false
    var filteredStocks: [Stock] {
        if !searchText.isEmpty {
            let search = searchText.lowercased()
            return stockObserver.stocks.filter { stock in
                stock.companyName.lowercased().contains(search) || stock.companyTicker.lowercased().contains(search)
            }
        } else {
            return stockObserver.stocks.filter { stock in
                (!showFavourites || stock.isFavourite)
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if stockObserver.selectedStockIndex != nil {
                StockDetailedView()
                    .transition(.opacity)
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack (pinnedViews: [.sectionHeaders]) {
                        SearchInput(text: $searchText)
                            .padding(.all, 5)
                        Section(header: listHeader) {
                            ForEach(filteredStocks.indices, id: \.self) { index in
                                StockSnippet(stock: filteredStocks[index], backgroundColor: index % 2 == 0 ? Color.init("odd") : Color.white)
                                    .onTapGesture {
                                        withAnimation {
                                            let ticker = self.filteredStocks[index].companyTicker
                                            self.stockObserver.selectedStockIndex = self.stockObserver.stocks.firstIndex(where: {$0.companyTicker == ticker})
                                            self.searchText = ""
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding()
            }   
        }
    }
    
    var listHeader: some View {
        HStack {
            if searchText.isEmpty {
                Menu(favourite: $showFavourites)
            } else {
                Text("Stocks")
                    .font(.title2)
                    .bold()
            }
            Spacer()
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
