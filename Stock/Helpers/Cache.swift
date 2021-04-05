//
//  Cache.swift
//  Stock
//
//  Created by Андрей Парчуков on 02.04.2021.
//

import Foundation

class Cache<Key: Hashable, Value> {
    private let wrappedCache = NSCache<WrappedKey, Entry>()
    
    func insert(forKey key: Key, object: Value) {
        wrappedCache.setObject(Entry(object), forKey: WrappedKey(key))
    }
    
    func value(forKey key: Key) -> Value? {
        return wrappedCache.object(forKey: WrappedKey(key))?.value
    }
    
}

extension Cache {
    
    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) { self.key = key }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? WrappedKey else {
                        return false
                    }
            return key == other.key
        }
        
        override var hash: Int { return key.hashValue }
        
    }
    
    final class Entry {
        let value: Value
        init(_ value: Value) { self.value = value }
    }
    
}

typealias StockCacheKey = [String : DateInterval]
