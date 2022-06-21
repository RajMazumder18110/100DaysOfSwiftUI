//
//  ContentView.swift
//  Time Converter
//
//  Created by Raj Mazumder on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentInputTimeUnit = "Seconds"
    @State private var currentOutputTimeUnit = "Minutes"
    @State private var inputValue = 0

    let timeUnis = ["Seconds", "Minutes", "Hours", "Days"]
    
    func calculateUnitValue() -> Double{
        if currentInputTimeUnit == "Seconds"{
            switch currentOutputTimeUnit {
                case "Minutes":
                    return Double(inputValue)/60
                case "Hours":
                    return Double(inputValue)/(60*60)
                default:
                    return Double(inputValue)/(60*60*24)
            }
        }
        else if currentInputTimeUnit == "Minutes"{
            switch currentOutputTimeUnit {
                case "Seconds":
                    return Double(inputValue)*60
                case "Hours":
                    return Double(inputValue)/60
                default:
                    return Double(inputValue)/(60*24)
            }
        }
        else if currentInputTimeUnit == "Hours"{
            switch currentOutputTimeUnit {
                case "Seconds":
                    return Double(inputValue)*60*60
                case "Minutes":
                    return Double(inputValue)*60
                default:
                    return Double(inputValue)/24
            }
        }
        else{
            switch currentOutputTimeUnit {
                case "Seconds":
                    return Double(inputValue)*24*60*60
                case "Minutes":
                    return Double(inputValue)*24*60
                default:
                    return Double(inputValue)*24
            }
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Input time unit", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("Input Unit", selection: $currentInputTimeUnit){
                        ForEach(timeUnis, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                } header: {
                    Text("Input Units")
                }
                
                Section{
                    Picker("Output unit", selection: $currentOutputTimeUnit){
                        ForEach(timeUnis, id: \.self){
                            if $0 != currentInputTimeUnit {
                                Text("\($0)")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                    
                    Text("\(calculateUnitValue().formatted(.number))")
                    
                } header: {
                    Text("Output Units")
                }
            }
            .navigationTitle("Time Converter")
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
