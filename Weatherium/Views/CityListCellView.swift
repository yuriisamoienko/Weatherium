//
//  CityListCellView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct CityListCellView: View {
    
    // MARK: Properties
    
    let name: String
    let weatherDescription: String
    let temperature: WeatherTemperature
    
    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(name)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                Text(weatherDescription)
                    .font(.footnote)
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
        .frame(
            maxWidth: .infinity
        )
    }
}

struct CityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CityListCellView(
            name: "NightCity",
            weatherDescription: "weather is great today. The sun is shinning brightly",
            temperature: WeatherTemperature(high: 24, low: 11)
        )
        .frame(width: 500, height: 50, alignment: .leading)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
