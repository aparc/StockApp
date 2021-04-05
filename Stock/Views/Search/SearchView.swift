//
//  SwiftUIView.swift
//  Stock
//
//  Created by Андрей Парчуков on 05.04.2021.
//

import SwiftUI
import WrappingHStack

struct SearchView: View {
    
    @EnvironmentObject var appStore: AppStore
    
    var body: some View {
        if appStore.searchText.isEmpty {
            QuickSearch()
        } else {
            ResultList(text: appStore.searchText)
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
