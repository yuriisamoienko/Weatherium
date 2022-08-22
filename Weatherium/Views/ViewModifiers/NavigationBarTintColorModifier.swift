//
//  NavigationBarTintColorModifier.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation
import SwiftUI

struct NavigationBarTintColorModifier: ViewModifier {

    var tint: Color

    init(tint: Color) {
        self.tint = tint
        UINavigationBar.appearance().tintColor = UIColor(tint)
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

    func navigationBarColor(tint: Color) -> some View {
        self.modifier(NavigationBarTintColorModifier(tint: tint))
    }

}
