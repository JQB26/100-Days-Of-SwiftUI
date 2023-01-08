//
//  ContentView.swift
//  02-GuessTheFlag
//
//  Created by Jakub Szczepanek on 08/01/2023.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showingGameEnd = false
    
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var currentQuestion = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedAnswer = ""
    
    let QUESTIONS_IN_GAME = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(of: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Text("Question: \(currentQuestion)/\(QUESTIONS_IN_GAME)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Wrong!" {
                Text("That's the flag of \(selectedAnswer)")
            }
        }
        .alert("The end!", isPresented: $showingGameEnd) {
            Button("Play again", action: restartGame)
        } message: {
            Text("Your score is \(score)/\(QUESTIONS_IN_GAME)")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedAnswer = countries[number]
        
        scoreTitle = number == correctAnswer ? "Correct!" : "Wrong!"
        score = number == correctAnswer ? score + 1 : score

        showingScore = true
    }
    
    func askQuestion() {
        if currentQuestion == QUESTIONS_IN_GAME {
            showingGameEnd = true
        } else {
            currentQuestion += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        score = 0
        currentQuestion = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
