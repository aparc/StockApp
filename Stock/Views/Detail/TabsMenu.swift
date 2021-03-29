//
//  DetailsMenu.swift
//  Stock
//
//  Created by Андрей Парчуков on 25.03.2021.
//

import SwiftUI

struct TabsMenu: View {
    
    // MARK: - Variables
    
    @State private var selectedIndex: Int = 0
    private var items = ["Chart", "Summary", "News", "Forecasts", "Ideas"]
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { reader in
                HStack(spacing: 20) {
                    ForEach(items.indices, id: \.self) { index in
                        TabItem(title: items[index], active: selectedIndex == index)
                            .id(index)
                            .onTapGesture {
                                withAnimation {
                                    selectedIndex = index
                                    reader.scrollTo(index)
                                }
                            }
                    }
                }
            }
        }
    }
}

struct DetailsMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabsMenu()
    }
}
