//
//  NavigationBarTextColorModifier.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation
import SwiftUI

struct NavigationBarTextColorModifier: ViewModifier {

    var textColor: UIColor

    init(text: Color) {
        self.textColor = UIColor(text)
//        UINavigationBar.appearance().tintColor = UIColor(tint)
        
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithTransparentBackground()
//        coloredAppearance.backgroundColor = backgroundColor
//        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
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
//        ZStack{
//            content
//            VStack {
//                GeometryReader { geometry in
//                    backgroundColor
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
//                    Spacer()
//                }
//            }
//        }
    }
}

extension View {

    func navigationBarColor(text: Color) -> some View {
        self.modifier(NavigationBarTextColorModifier(text: text))
    }

}
