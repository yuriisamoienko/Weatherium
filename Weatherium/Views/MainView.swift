//
//  ContentView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1..<10) { row in
                    CityListCellView()
                        .frame(height: 50)
                 }
            }
            .navigationTitle("Weather Application")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
