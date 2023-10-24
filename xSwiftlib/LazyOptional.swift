//
//  LazyUnderscore.swift
//  xSwiftlib
//
//  Created by Sikui Jin on 2023/10/24.
//

import Foundation



@propertyWrapper
public struct LazyOptional<T> {
    
    public private(set) var value: T?
    private var initializer: () -> T
    
    public init(wrappedValue: @autoclosure @escaping () -> T) {
        self.initializer = wrappedValue
    }
    
    public var projectedValue: T? {
        return value
    }
    
    public var wrappedValue: T  {
        mutating get {
            if let value = value {
                return value
            }
            else {
                let obj = initializer()
                value = obj
                return obj
            }
        }
        set {
            value = newValue
        }
    }
    
}
