//
//  NavigationBarTintColorModifier.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation
import SwiftUI

struct NavigationBarTintColorModifier: ViewModifier {
    
    // MARK: Private Properties

    private let tint: Color
    
    // MARK: Public Functions

    init(tint: Color) {
        self.tint = tint
        UINavigationBar.appearance().tintColor = UIColor(tint)
    }

    func body(content: Content) -> some View {
        content
    }
    
}

extension View {
    
    // MARK: Public Functions

    func navigationBarColor(tint: Color) -> some View {
        self.modifier(NavigationBarTintColorModifier(tint: tint))
    }

}
