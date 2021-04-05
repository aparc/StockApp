//
//  SearchInput.swift
//  Stock
//
//  Created by Андрей Парчуков on 15.03.2021.
//

import SwiftUI

struct SearchInput: View {
    
    // MARK: - Variables
    
    @EnvironmentObject private var appStore: AppStore
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 10) {
            if appStore.showSearchView {
                backIcon
            } else {
                glassIcon
            }
            input
            if !appStore.searchText.isEmpty {
                clearButton
            }
        }
        .padding()
        .frame(height: 50)
        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.black, lineWidth: 1))
    }
    
    var backIcon: some View {
        Image(systemName: "arrow.left")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .animation(.default)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                self.appStore.showSearchView = false
                clear()
            }
    }
    
    var glassIcon: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .animation(.default)
    }
    
    var input: some View {
        TextField("Find company or ticker", text: $appStore.searchText, onEditingChanged: { _ in
            withAnimation {
                self.appStore.showSearchView = true
            }
        })
    }
    
    var clearButton: some View {
        Button(action: clear) {
            Image(systemName: "xmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }
    
    
    // MARK: - Functions
    
    func clear() {
        appStore.searchText = ""
    }
    
}

struct SearchInput_Previews: PreviewProvider {
    static var previews: some View {
        SearchInput()
    }
}
