//
//  ContentView.swift
//  Bedrest
//
//  Created by Raj Mazumder on 22/06/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var coffeeIntake = 1
    @State private var sleepHours = 8.0
    @State private var wakeUpTime = setWakeUpTime
    @State private var bedTime = Date.now
    
    @State private var showingAleart = false
    
    static var setWakeUpTime: Date {
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var body: some View {
        Form{
            Section{
                DatePicker("Want to wake up at", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .padding(.vertical, 5)
            } header: {
                Text("Wake up time")
            }
            
            Section{
                Stepper(
                    "Sleep for \(sleepHours.formatted()) hours",
                    value: $sleepHours, in: 4...12, step: 0.25
                )
                .padding(.vertical, 5)
            } header: {
                Text("Sleep hours")
            }
            
            Section{
                Stepper(
                    "Coffee intake \(coffeeIntake) \(coffeeIntake > 1 ? "Cups" : "Cup")",
                    value: $coffeeIntake, in: 1...20
                )
                .padding(.vertical, 5)
            } header: {
                Text("Coffee intake")
            }
            
            Section{
                VStack(alignment: .center){
                    VStack(spacing: 30){
                        Text("Bed time")
                            .font(.body)
                        Image(systemName: "moon.zzz.fill")
                            .font(.system(size: 50))
                    }
                    
                    Text(bedTime.formatted(date: .omitted, time: .shortened))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.vertical, 30)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
            } header: {
                Text("Sleep time")
            }
            
            ZStack(alignment: .center){
                Button("Calculate", action: calculateBedTime)
                    .padding(.vertical, 7)
            }
            .frame(maxWidth: .infinity)
        }
        .font(.headline)
        .alert("Opps!! Error occured", isPresented: $showingAleart){
            Button("Ok"){}
        }
        .onAppear{
            calculateBedTime()
        }
    }
    
    func calculateBedTime() {
        do{
            let modelConfig = MLModelConfiguration()
            let bedTimeModel = try BedTime(configuration: modelConfig)
            
            let dateComponents = Calendar.current.dateComponents([.hour, .minute],from: wakeUpTime)
            let hour = (dateComponents.hour ?? 0) * 60 * 60
            let min = (dateComponents.minute ?? 0) * 60
            
            let prediction = try bedTimeModel.prediction(wake: Double(hour + min), estimatedSleep: sleepHours, coffee: Double(coffeeIntake))
            
            bedTime = wakeUpTime - prediction.actualSleep
            
        } catch{
            print("Error occured")
            showingAleart = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
