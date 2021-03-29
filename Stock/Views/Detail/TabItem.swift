//
//  MenuItem.swift
//  Stock
//
//  Created by Андрей Парчуков on 25.03.2021.
//

import SwiftUI

struct TabItem: View {
    
    // MARK: - Variables
    
    var title: String
    var active: Bool
    
    // MARK: - Body
    
    var body: some View {
        Text(title)
            .bold()
            .foregroundColor(active ? .black : .gray)
            .animatableSystemFont(size: active ? 24 : 16)
    }
}

// MARK: - Preview

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem(title: "Chart", active: false)
    }
}
