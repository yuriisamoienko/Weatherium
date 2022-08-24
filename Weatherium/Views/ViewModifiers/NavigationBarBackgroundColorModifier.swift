//
//  NavigationBarColorModifier.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation
import SwiftUI

struct NavigationBarBackgroundColorModifier: ViewModifier {
    
    // MARK: Private Properties

    private let backgroundColor: Color
    
    // MARK: Public Functions

    init(background: Color) {
        self.backgroundColor = background
        let backgroundColor = UIColor(background)
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    backgroundColor
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    
    // MARK: Public Functions

    func navigationBarColor(background: Color) -> some View {
        self.modifier(NavigationBarBackgroundColorModifier(background: background))
    }

}
