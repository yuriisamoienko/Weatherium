//
//  CityListCellView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct CityListCellView: View {
    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text("City name")
                Text("Description of the weather")
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
                        Text("25")
                    }
                    HStack {
                        Text("15")
                    }
                }
            }
            .font(.subheadline)
        }
    }
}

struct CityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CityListCellView()
            .frame(width: 300, height: 50, alignment: .center)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
