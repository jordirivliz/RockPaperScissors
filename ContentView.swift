//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jordi Rivera Lizarralde on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    // Property to store the three possible moves
    let options = ["Rock", "Paper", "Scissors"]
    
    // Property to win or lose
    let options1 = ["win", "lose"]
    
    @State private var currentChoice = Int.random(in: 0...2 )
    @State private var winLose = Int.random(in: 0...1)
    
    // User's score
    @State private var score = 0
    
    // Message in the alert
    @State private var scoreTitle = ""
    // Show alert
    @State private var showingScore = false
    
    // Game round
    @State private var gameRound = 0

    
    var body: some View {
        ZStack {
            // Color the background with a gradient
            LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .top, endPoint: .bottom)
                // Cover all screen ignoring the edges
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack {
                    Text("I have selected:")
                        .foregroundColor(.white)
                    
                    Text(options[currentChoice])
                        // Letters in white
                        .foregroundColor(.white)
                        // Make option larger in font
                        .font(.largeTitle)
                        // Make option thicker
                        .fontWeight(.black)
                    
                    Text("Bet you cannot \(options1[winLose]). Choose wisely:")
                        .foregroundColor(.white)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        // Option selected
                        self.optionSelected(number)
                    }) {
                        Text(options[number])
                            .font(.largeTitle)
                    }
                }
                Spacer()
            }
            if gameRound == 10 {
                VStack {
                    Text("End of the Game")
                        // Letters in white
                        .foregroundColor(.white)
                        // Make option larger in font
                        .font(.largeTitle)
                        // Make option thicker
                        .fontWeight(.black)
                    Text("Your score is: \(score)/10")
                        .foregroundColor(.white)
                }
            }

        }
        // Creating alert
        .alert(isPresented: $showingScore){
            // Tell the user whether they were correct or not
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue")) {
                    // Continue the game with another quesiton
                    self.askQuestion()
                  })
        }
    }
    // Function to modify the state when the option is tapped
    func optionSelected(_ number: Int) {
        // User needs to win
        if winLose == 0 {
            if number == (currentChoice + 1) % 3 {
                scoreTitle = "Nice, you are good!"
                score += 1
            } else {
                scoreTitle = "Hahaha, you chose purely"
                score -= 1
            }
        // User needs to lose
        } else {
            // Handle the case when 0-1 = -1
            if options[currentChoice] == "Rock" {
                if options[number] == "Scissors" {
                    scoreTitle = "Nice, you knew how to lose!"
                    score += 1
                } else {
                    scoreTitle = "Hahaha, you chose purely"
                    score -= 1
                }
            } else if number == currentChoice - 1 {
                scoreTitle = "Nice, you knew how to lose!"
                score += 1
            } else {
                scoreTitle = "Hahaha, you chose purely"
                score -= 1
            }
        }
        gameRound += 1
        showingScore = true
    }
    // Function to continue the game
    func askQuestion(){
        // Shuffle the option selected by the machine
        currentChoice = Int.random(in: 0...2)
        // Choose again to lose or win
        winLose = Int.random(in: 0...1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
