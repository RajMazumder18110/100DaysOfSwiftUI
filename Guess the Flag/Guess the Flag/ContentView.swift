//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Raj Mazumder on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var alertShowing = false
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria",
        "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    
    @State private var correctAns = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                VStack(spacing: 15){
                    Spacer()
                    Text("Guess the flag")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    
                    Spacer()
                    
                    VStack{
                        VStack(){
                            Text("Tap the flag of")
                                .foregroundStyle(.primary)
                                .font(.headline.bold())
                            
                            Text("\(countries[correctAns])")
                                .foregroundStyle(.primary)
                                .font(.largeTitle.bold())
                            
                        }
                        VStack(spacing: 20){
                            ForEach(0..<3){ number in
                                Button{
                                    checkAns(number)
                                } label: {
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 10)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 10)
                    
                    Spacer()
                    
                    Text("Score \(score)")
                        .foregroundStyle(.white)
                        .font(.title3.weight(.semibold))
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .alert(scoreTitle, isPresented: $alertShowing){
                Button("Continue", action: nextQues)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func checkAns(_ number: Int){
        if correctAns == number {
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Incorrect"
        }
        alertShowing = true
    }
    
    func nextQues(){
        countries = countries.shuffled()
        correctAns = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
