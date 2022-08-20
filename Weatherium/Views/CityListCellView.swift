//
//  CityListCellView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct CityListCellView: View {
    
    let name: String
    let weatherDescription: String
    let temperature: WeatherTemperature
//        var name: String

//    init(name: String) {
//        self.name = name
//    }
    
    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(name)
                Text(weatherDescription)
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
                .frame(width: 10)
            
            // allign ':' and numbers to right and vertically
            Group {
                VStack(alignment: .trailing) {
                    HStack {
                        Text("H: ")
                    }
                    HStack {
                        Text("L: ")
                    }
                }
                VStack(alignment: .trailing) {
                    HStack {
                        Text("\(temperature.high)")
                    }
                    HStack {
                        Text("\(temperature.low)")
                    }
                }
            }
            .font(.subheadline)
        }
    }
}

struct CityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CityListCellView(
            name: "NightCity",
            weatherDescription: "weather is great today. The sun is shinning brightly",
            temperature: WeatherTemperature(high: 24, low: 11)
        )
            .frame(width: 300, height: 50, alignment: .center)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
