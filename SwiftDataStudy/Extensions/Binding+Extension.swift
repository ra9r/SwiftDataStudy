//
//  Binding+Extension.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        }
        set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
    
}
