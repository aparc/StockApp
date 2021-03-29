//
//  Menu.swift
//  Stock
//
//  Created by Андрей Парчуков on 25.03.2021.
//

import SwiftUI

struct Menu: View {
    
    @Binding var favourite: Bool
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Stocks")
                .bold()
                .foregroundColor(favourite ? .gray : .black)
                .animatableSystemFont(size: favourite ? 18 : 36)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        favourite = false
                    }
                }
            
            Text("Favourite")
                .bold()
                .foregroundColor(favourite ? .black : .gray)
                .animatableSystemFont(size: favourite ? 36 : 18)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        favourite = true
                    }
                }
            Spacer()
        }
        .frame(minHeight: 80, maxHeight: 80)
        .background(Color.white)
    }
}

struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableSystemFont(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(favourite: .constant(true))
    }
}
