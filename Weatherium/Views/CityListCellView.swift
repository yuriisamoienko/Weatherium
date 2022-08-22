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
    let iconId: String
    
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        GeometryReader { bodyGeometry in
            HStack {
                AsyncImage(
                    url: getIconUrl(),
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
                        let unitTemperature = appSettings.displayedTemperatureUnit.unit
                        let highTemperature = MeasurementFormatter.convert(temperature: temperature.high, from: .kelvin, to: unitTemperature)
                        let lowTemperature = MeasurementFormatter.convert(temperature: temperature.low, from: .kelvin, to: unitTemperature)
                        
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
    
    // MARK: Private Functions
    
    private func getIconUrl() -> URL? {
        let scaleFactor = UIScreen.main.scale
        return try? NetworkEnpoint.weatherIcon(id: iconId, scaleFactor: scaleFactor).createEndpointUrl()
    }
}

struct CityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CityListCellView(
            name: "NightCity",
            weatherDescription: "weather is great today. The sun is shinning brightly",
            temperature: WeatherTemperature(high: 24, low: 11),
            iconId: "10d"
        )
        .frame(width: 500, height: 50, alignment: .leading)
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .previewDisplayName("Default preview")
        .preferredColorScheme(.light)
    }
}
