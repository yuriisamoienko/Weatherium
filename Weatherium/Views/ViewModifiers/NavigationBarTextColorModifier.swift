//
//  NavigationBarTextColorModifier.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation
import SwiftUI

struct NavigationBarTextColorModifier: ViewModifier {
    
    // MARK: Private Properties

    private let textColor: UIColor
    
    // MARK: Public Functions

    init(text: Color) {
        self.textColor = UIColor(text)
        
        let standardAppearance = UINavigationBar.appearance().standardAppearance //?? UINavigationBarAppearance()
        let compactAppearance = UINavigationBar.appearance().compactAppearance ?? UINavigationBarAppearance()
        let scrollEdgeAppearance = UINavigationBar.appearance().scrollEdgeAppearance ?? UINavigationBarAppearance()
        
        for appearance in [scrollEdgeAppearance, compactAppearance, scrollEdgeAppearance] {
            appearance.titleTextAttributes = [.foregroundColor: textColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        }
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().compactAppearance = compactAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {

    func navigationBarColor(text: Color) -> some View {
        self.modifier(NavigationBarTextColorModifier(text: text))
    }

}
