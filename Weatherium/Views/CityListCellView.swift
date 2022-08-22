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
    let iconUrl: URL?
    
    var body: some View {
        GeometryReader { bodyGeometry in
            HStack {
                AsyncImage(
                    url: iconUrl,
                    content: { $0
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.accentColor)
                    },
                    placeholder: {
                        ProgressView()
                            .tint(.accentColor)
                            .scaleEffect(1.3)
                    }
                )
                .frame(
                    width: bodyGeometry.size.height,
                    height: bodyGeometry.size.height
                )
                .cornerRadius(bodyGeometry.size.height/2)
                
                Spacer()
                    .frame(width: 10)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Text(weatherDescription)
                        .font(.callout)
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
                        let highTemperature = MeasurementFormatter.convert(temperature: temperature.high, from: .kelvin, to: .celsius)
                        let lowTemperature = MeasurementFormatter.convert(temperature: temperature.low, from: .kelvin, to: .celsius)
                        
                        HStack {
                            Text("\(highTemperature)")
                        }
                        HStack {
                            Text("\(lowTemperature)")
                        }
                    }
                }
                .font(.subheadline)
                .if(temperature.isInvalid(), content: { group in
                    group.hidden()
                })
                    
            }
            .frame(
                maxWidth: .infinity
            )
        }
    }
}

struct CityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CityListCellView(
            name: "NightCity",
            weatherDescription: "weather is great today. The sun is shinning brightly",
            temperature: WeatherTemperature(high: 24, low: 11),
            iconUrl: try? NetworkEnpoint.weatherIcon(id: "10d").createEndpointUrl()
        )
        .frame(width: 500, height: 50, alignment: .leading)
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .previewDisplayName("Default preview")
        .preferredColorScheme(.light)
    }
}
