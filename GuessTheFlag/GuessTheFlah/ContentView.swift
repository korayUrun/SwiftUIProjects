//
//  ContentView.swift
//  GuessTheFlah
//
//  Created by Koray Urun on 25.10.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "russia","poland", "spain", "uk", "ukraine", "us","monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""

    
    var body: some View {
        
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()

            VStack {
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline).fontWeight(.heavy)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle).fontWeight(.semibold)
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }

        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
        
        
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

}

#Preview {
    ContentView()
}
