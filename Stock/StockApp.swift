//
//  StockApp.swift
//  Stock
//
//  Created by Андрей Парчуков on 14.03.2021.
//

import SwiftUI

@main
struct StockApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(StockObserver())
        }
    }
}
