//
//  ViewExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation
import SwiftUI

extension View {
    
    // MARK: Public Functions
    
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
    
}
