//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Raj Mazumder on 22/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var haveToWin = Bool.random()
    @State private var randomChoosen = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingAleart = false
    @State private var count = 0
    
    let moves = ["🪨", "📄", "✂️"]
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Group{
                    Text("Rock Paper Scissors")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Score \(score)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                    
                    Text("You have to \(haveToWin ? "Win" : "Loose")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                }
                Spacer()
                Text(moves[randomChoosen])
                    .font(.system(size: 100))
                Spacer()
                Spacer()
                Group{
                    Text("Choose one to \(haveToWin ? "Win" : "Loose")")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                    
                    HStack(spacing: 50){
                        ForEach(moves, id: \.self){ move in
                            Button(move){
                                checkAns(move: move)
                            }
                            .font(.system(size: 50))
                        }
                    }
                }
                Spacer()
            }
        }
        .alert("Over. You scored is \(score)", isPresented: $showingAleart){
            Button("New game"){
                haveToWin = Bool.random()
                randomChoosen = Int.random(in: 0...2)
                score = 0
                count = 0
            }
        } message: {
            Text("10 chance passed !!")
        }
    }
    
    func checkAns(move: String){
        if moves[randomChoosen] == "🪨"{
            if (haveToWin && move == "📄") || (!haveToWin && move == "✂️"){
                score += 1
            }
        } else if moves[randomChoosen] == "📄"{
            if (haveToWin && move == "✂️") || (!haveToWin && move == "🪨"){
                score += 1
            }
        }else {
            if (haveToWin && move == "🪨") || (!haveToWin && move == "📄"){
                score += 1
            }
        }
        
        count += 1
        haveToWin = Bool.random()
        randomChoosen = Int.random(in: 0...2)
        
        if count == 10 {
            showingAleart = true
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
