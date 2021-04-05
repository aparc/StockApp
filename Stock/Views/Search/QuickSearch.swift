//
//  QuickSearch.swift
//  Stock
//
//  Created by Андрей Парчуков on 05.04.2021.
//

import SwiftUI
import WrappingHStack

struct QuickSearch: View {
    
    // MARK: - Variables
    
    @EnvironmentObject private var appStore: AppStore
    private var labels: [String] {
        return appStore.searchCache.value(forKey: AppStore.searchCacheKey) ?? []
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(labels.count > 0 ? "You've search for this" : "Please use the search to find a company or ticker")
                .font(.title3)
                .bold()
            WrappingHStack(data: labels, id: \.self) { label in
                    Chip(label: label)
                        .padding(.vertical, 10)
            }
        }
    }
}

// MARK: - Preview

struct QuickSearch_Previews: PreviewProvider {
    static var previews: some View {
        QuickSearch()
    }
}
