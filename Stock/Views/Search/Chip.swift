//
//  Chip.swift
//  Stock
//
//  Created by Андрей Парчуков on 05.04.2021.
//

import SwiftUI

struct Chip: View {
    
    // MARK: - Initializer
    init(label: String) {
        self.label = label
    }
    
    // MARK: - Variables
    @EnvironmentObject private var store: StockStore
    var label: String
    private var backgroundColor = Color.init(hexString: "#F0F4F7")
    
    // MARK: - Body
    var body: some View {
        Text(label)
            .font(.body)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(backgroundColor)
            .cornerRadius(20)
            .onTapGesture(perform: select)
    }
    
    func select() {
        withAnimation {
            let index = store.stocks.firstIndex(where: { $0.companyName == self.label })
            self.store.selectedStockIndex = index
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            self.store.showDetails = true
        }
    }
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
        Chip(label: "Amazon")
            .environmentObject(StockStore())
    }
}
