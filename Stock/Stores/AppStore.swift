//
//  AppStore.swift
//  Stock
//
//  Created by Андрей Парчуков on 05.04.2021.
//

import Foundation
import SwiftUI

class AppStore: ObservableObject {
    @Published var showSearchView: Bool = false
    @Published var searchText = ""
    var searchCache = Cache<String, [String]>()
}

extension AppStore {
    static let searchCacheKey = "SearchCacheKey"
}
