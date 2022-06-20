//
//  ContentView.swift
//  SplitBill
//
//  Created by Raj Mazumder on 20/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkoutAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    let tips = [0, 10, 20, 25, 30]

    var amountPerPerson: Double {
        let tip = (Double(checkoutAmount) * Double(tipPercentage)) / 100.0
        return (tip + Double(checkoutAmount)) / Double(numberOfPeople + 2)
    }
    
    var totalCheckoutAmount: Double{
        let tip = Double(checkoutAmount * Double(tipPercentage)) / 100.0
        return Double(checkoutAmount) + tip
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Checkout Amount", value: $checkoutAmount, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<50){
                            Text("\($0) People")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tips, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip percentage you want to give?")
                }
                
                Section{
                    Text(totalCheckoutAmount, format: .currency(code: "INR"))
                } header: {
                    Text("Total Checkout amount")
                }
                
                Section{
                    Text(amountPerPerson, format: .currency(code: "INR"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("Split Bill")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}
