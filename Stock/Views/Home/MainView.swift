//
//  ContentView.swift
//  Stock
//
//  Created by Андрей Парчуков on 14.03.2021.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var stockStore: StockStore
    @EnvironmentObject var appStore: AppStore
    @State private var showFavourites: Bool = false
    var filteredStocks: [Stock] {
        return stockStore.stocks.filter { stock in
            (!showFavourites || stock.isFavourite)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack (pinnedViews: [.sectionHeaders]) {
                    SearchInput()
                        .padding(.all, 5)
                    
                    if appStore.showSearchView {
                        SearchView()
                            .transition(.opacity)
                    } else {
                        Section(header: FavouriteStocksToggle(favourite: $showFavourites)) {
                            ForEach(filteredStocks.indices, id: \.self) { index in
                                StockSnippet(stock: filteredStocks[index], backgroundColor: index % 2 == 0 ? Color.init("odd") : Color.white)
                                    .onTapGesture {
                                        withAnimation {
                                            self.onSnippetTap(index)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .padding()
            
            if stockStore.showDetails {
                StockDetailedView()
                    .transition(.asymmetric(insertion: AnyTransition.opacity.animation(.interactiveSpring()), removal: .identity))
            }
        }
    }
    
    // MARK: - Functions
    
    func onSnippetTap(_ index: Int) {
        let ticker = self.filteredStocks[index].companyTicker
        self.stockStore.selectedStockIndex = self.stockStore.stocks.firstIndex(where: {$0.companyTicker == ticker})
        self.stockStore.showDetails = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
