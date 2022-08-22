//
//  MeasurementFormatterExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

extension MeasurementFormatter {
 
    static func convert(temperature: Int, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        return convert(temperature: Double(temperature), from: inputTempType, to: outputTempType)
    }
    
    static func convert(temperature: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temperature, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
      }
    
}
