//
//  ResultList.swift
//  Stock
//
//  Created by Андрей Парчуков on 05.04.2021.
//

import SwiftUI

struct ResultList: View {
    
    // MARK: - Variables
    
    @EnvironmentObject private var stockStore: StockStore
    @EnvironmentObject private var appStore: AppStore
    var text: String
    private var filteredStocks: [Stock] {
        let search = text.lowercased()
        return stockStore.stocks.filter { stock in
            stock.companyName.lowercased().contains(search) || stock.companyTicker.lowercased().contains(search)
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Divider()
            Section(header: listHeader) {
                ForEach(filteredStocks.indices, id: \.self) { index in
                    StockSnippet(stock: filteredStocks[index], backgroundColor: index % 2 == 0 ? Color.init("odd") : Color.white)
                        .onTapGesture {
                            withAnimation {
                                onSnippetTap(index)
                            }
                        }
                }
            }
        }
    }
    
    var listHeader: some View {
        HStack {
            Text("Stocks")
                .bold()
                .font(.title2)
            Spacer()
        }
        .padding(.vertical)
    }
    
    // MARK: - Functions

    func onSnippetTap(_ index: Int) {
        let ticker = self.filteredStocks[index].companyTicker
        let companyName = self.filteredStocks[index].companyName
        
        var labelsInCache = appStore.searchCache.value(forKey: AppStore.searchCacheKey) ?? []
        if let index = labelsInCache.firstIndex(of: companyName) {
            labelsInCache.remove(at: index)
        }
        labelsInCache.insert(companyName, at: 0)
        appStore.searchCache.insert(forKey: AppStore.searchCacheKey, object: labelsInCache)
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        self.stockStore.selectedStockIndex = self.stockStore.stocks.firstIndex(where: {$0.companyTicker == ticker})
        self.stockStore.showDetails = true
    }
    
}

// MARK: - Preview

struct ResultList_Previews: PreviewProvider {
    static var previews: some View {
        ResultList(text: "")
            .environmentObject(StockStore())
    }
}
