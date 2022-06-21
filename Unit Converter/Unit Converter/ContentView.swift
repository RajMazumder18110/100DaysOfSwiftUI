//
//  ContentView.swift
//  Unit Converter
//
//  Created by Raj Mazumder on 20/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var unitInput = 0.0
    @State private var pickerInputValue = "Celsius"
    @State private var pickerOutputValue = "Celsius"
    
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    // Celsius to units
    var celsiusToKelvin: Double {
        unitInput + 273.15
    }
    
    var celsiusToFahrenheit: Double {
        (unitInput * 9/5) + 32
    }
    
    // Kelvin to units
    var kelvinToCelsius: Double {
        unitInput - 273.15
    }
    
    var kelvinToFahrenheit: Double {
        (kelvinToCelsius * 9/5) + 32
    }
    
    // fahrenheit to units
    var fahrenheitToKelvin: Double {
        fahrenheitToCelsius + 273.15
    }
    
    var fahrenheitToCelsius: Double {
        (unitInput - 32) * 5/9
    }
        
    var body: some View {
        NavigationView{
            Form{
                // Input Section
                Section{
                    TextField("Unit", value: $unitInput, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Unit input", selection: $pickerInputValue){
                        ForEach(temperatureUnits, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                } header: {
                    Text("Input Unit")
                }
                
                // Output unit
                Section{
                    Picker("Output Unit", selection: $pickerOutputValue){
                        ForEach(temperatureUnits, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                    
                    if pickerInputValue == "Celsius" {
                        switch pickerOutputValue {
                            case "Fahrenheit":
                                Text("\(celsiusToFahrenheit.formatted())° F")

                            case "Kelvin":
                                Text("\(celsiusToKelvin.formatted())° K")

                            default:
                                Text("\(unitInput.formatted())° C")
                        }
                    } else if pickerInputValue == "Kelvin" {
                        switch pickerOutputValue {
                            case "Fahrenheit":
                                Text("\(kelvinToFahrenheit.formatted())° F")

                            case "Kelvin":
                                Text("\(unitInput.formatted())° K")

                            default:
                                Text("\(kelvinToCelsius.formatted())° C")
                        }
                    }else{
                        switch pickerOutputValue {
                            case "Fahrenheit":
                            Text("\(unitInput.formatted())° F")

                            case "Kelvin":
                                Text("\(fahrenheitToKelvin.formatted())° K")

                            default:
                                Text("\(fahrenheitToCelsius.formatted())° C")
                        }
                    }
                } header: {
                    Text("Output unit")
                }
            }
            .navigationTitle("Temperature Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
