//
//  ContentView.swift
//  ConverterApp
//
//  Created by Koray Urun on 25.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @State private var conversionType = "Temperature"
    
    let conversionTypes = ["Temperature", "Length", "Time", "Volume"]
    
    // Her conversion type için units
    var availableUnits: [String] {
        switch conversionType {
        case "Temperature":
            return ["Celsius", "Fahrenheit", "Kelvin"]
        case "Length":
            return ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
        case "Time":
            return ["Seconds", "Minutes", "Hours", "Days"]
        case "Volume":
            return ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
        default:
            return []
        }
    }
    
    // Base unit'e çevirme
    var inputInBaseUnit: Double {
        switch conversionType {
        case "Temperature":
            return convertTemperatureToBase()
        case "Length":
            return convertLengthToBase()
        case "Time":
            return convertTimeToBase()
        case "Volume":
            return convertVolumeToBase()
        default:
            return inputValue
        }
    }
    
    // Base unit'ten output'a çevirme
    var outputValue: Double {
        switch conversionType {
        case "Temperature":
            return convertTemperatureFromBase()
        case "Length":
            return convertLengthFromBase()
        case "Time":
            return convertTimeFromBase()
        case "Volume":
            return convertVolumeFromBase()
        default:
            return inputInBaseUnit
        }
    }
    
    var body: some View {

        
        NavigationStack {
            Form {
                // Conversion Type Seçimi
                Section(header: Text("Conversion Type")) {
                    Picker("Type", selection: $conversionType) {
                        ForEach(conversionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: conversionType) { oldValue, newValue in
                        // Type değiştiğinde unit'leri resetle
                        inputUnit = availableUnits[0]
                        outputUnit = availableUnits[1]
                    }
                }
                
                Section(header: Text("Input")) {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("From", selection: $inputUnit) {
                        ForEach(availableUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Convert To")) {
                    Picker("To", selection: $outputUnit) {
                        ForEach(availableUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Result")) {
                    Text(outputValue, format: .number)
                        .font(.title2)
                        .bold()
                }
            }
            .navigationTitle("Unit Converter")
            
        }
    }
    
    
    // MARK: - Temperature Conversions
        func convertTemperatureToBase() -> Double {
            switch inputUnit {
            case "Celsius":
                return inputValue
            case "Fahrenheit":
                return (inputValue - 32) * 5.0 / 9.0
            case "Kelvin":
                return inputValue - 273.15
            default:
                return inputValue
            }
        }
        
        func convertTemperatureFromBase() -> Double {
            switch outputUnit {
            case "Celsius":
                return inputInBaseUnit
            case "Fahrenheit":
                return (inputInBaseUnit * 9.0 / 5.0) + 32.0
            case "Kelvin":
                return inputInBaseUnit + 273.15
            default:
                return inputInBaseUnit
            }
        }
        
        // MARK: - Length Conversions
        func convertLengthToBase() -> Double {
            switch inputUnit {
            case "Meters":
                return inputValue
            case "Kilometers":
                return inputValue * 1000
            case "Feet":
                return inputValue * 0.3048
            case "Yards":
                return inputValue * 0.9144
            case "Miles":
                return inputValue * 1609.34
            default:
                return inputValue
            }
        }
        
        func convertLengthFromBase() -> Double {
            switch outputUnit {
            case "Meters":
                return inputInBaseUnit
            case "Kilometers":
                return inputInBaseUnit / 1000
            case "Feet":
                return inputInBaseUnit / 0.3048
            case "Yards":
                return inputInBaseUnit / 0.9144
            case "Miles":
                return inputInBaseUnit / 1609.34
            default:
                return inputInBaseUnit
            }
        }
        
        // MARK: - Time Conversions
        func convertTimeToBase() -> Double {
            switch inputUnit {
            case "Seconds":
                return inputValue
            case "Minutes":
                return inputValue * 60
            case "Hours":
                return inputValue * 3600
            case "Days":
                return inputValue * 86400
            default:
                return inputValue
            }
        }
        
        func convertTimeFromBase() -> Double {
            switch outputUnit {
            case "Seconds":
                return inputInBaseUnit
            case "Minutes":
                return inputInBaseUnit / 60
            case "Hours":
                return inputInBaseUnit / 3600
            case "Days":
                return inputInBaseUnit / 86400
            default:
                return inputInBaseUnit
            }
        }
        
        // MARK: - Volume Conversions
        func convertVolumeToBase() -> Double {
            switch inputUnit {
            case "Milliliters":
                return inputValue
            case "Liters":
                return inputValue * 1000
            case "Cups":
                return inputValue * 236.588
            case "Pints":
                return inputValue * 473.176
            case "Gallons":
                return inputValue * 3785.41
            default:
                return inputValue
            }
        }
        
        func convertVolumeFromBase() -> Double {
            switch outputUnit {
            case "Milliliters":
                return inputInBaseUnit
            case "Liters":
                return inputInBaseUnit / 1000
            case "Cups":
                return inputInBaseUnit / 236.588
            case "Pints":
                return inputInBaseUnit / 473.176
            case "Gallons":
                return inputInBaseUnit / 3785.41
            default:
                return inputInBaseUnit
            }
        }
    }

#Preview {
    ContentView()
}
