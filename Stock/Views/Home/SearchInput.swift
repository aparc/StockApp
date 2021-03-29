//
//  SearchInput.swift
//  Stock
//
//  Created by Андрей Парчуков on 15.03.2021.
//

import SwiftUI

struct SearchInput: View {
    
    // MARK: variables
    @Binding var text: String
    @State private var focused: Bool = false
    
    // MARK: body
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            TextField("Find company or ticker", text: $text, onEditingChanged: { focused in
                self.focused = focused
            })
            
            if !text.isEmpty {
                Button(action: clear) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .frame(height: 50)
        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.black, lineWidth: 1))
    }
    
    
    // MARK: functions
    func clear() {
        text = ""
    }
    
}

struct SearchInput_Previews: PreviewProvider {
    static var previews: some View {
        SearchInput(text: .constant("Const"))
    }
}
