//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Koray Urun on 29.10.2025.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Durum Değişkenleri
    
    let choices = ["Rock", "Paper", "Scissors"]
    let numberOfRounds = 5 // Tur sayısını 5'te bırakıyorum.
    
    @State private var appMove = "Rock" // Uygulamanın hamlesi
    @State private var shouldWin = Bool.random() // Hedef: true = Kazan, false = Kaybet
    
    @State private var userScore = 0 // Kullanıcının skoru
    @State private var appScore = 0 // Uygulamanın skoru (Artık bu da gösterilecek)
    @State private var currentRound = 1 // Tur sayacı 1'den başlar
    @State private var gameOver = false
    
    // MARK: - View Body
    
    var body: some View {
        VStack {
            Text("ROCK-PAPER-SCISSORS")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Spacer()
            
            // MARK: Oyun Bilgileri
            VStack(spacing: 15) {
                Text("App's Move: \(appMove)")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text("Your Goal: \(shouldWin ? "WIN" : "LOSE")")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding()
                    .background(.purple.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            // MARK: Kullanıcı Butonları (HStack)
            HStack(spacing: 20) {
                ForEach(choices, id: \.self) { move in
                    Button(move) {
                        processUserMove(userMove: move)
                    }
                    .frame(width: 100, height: 50)
                    .background(.black)
                    .foregroundColor(.orange)
                    .font(.headline)
                    .cornerRadius(10)
                }
            }
            .padding(30)
            
            Spacer()
            
            // MARK: ÇİFT SKOR PANELİ (İstediğiniz kısım)
            HStack {
                VStack {
                    Text("User Score")
                        .font(.headline)
                    Text("\(userScore)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(width: 150, height: 100)
                .background(.red.opacity(0.2))
                .cornerRadius(10)
                
                VStack {
                    Text("App Score")
                        .font(.headline)
                    Text("\(appScore)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(width: 150, height: 100)
                .background(.blue.opacity(0.2))
                .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            // MARK: Tur Bilgisi
            Text("Round \(currentRound) / \(numberOfRounds)")
                .font(.subheadline)
                .padding(.bottom, 10)
        }
        .background(Color.mint.opacity(0.1)) 
            
        .onAppear {
            appMove = choices.randomElement() ?? "Rock"
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Restart Game") {
                restartGame()
            }
        } message: {
            Text("User Score: \(userScore)\nApp Score: \(appScore)\n\n\(whoWins())")
        }
    }
    
    // MARK: - Fonksiyonlar
    
    func processUserMove(userMove: String) {
        
      
        let userWonHand = didUserWinThisHand(userMove: userMove, appMove: appMove)
        
        if shouldWin {
            if userWonHand {
                userScore += 1
            } else {
                appScore += 1
            }
        }
        
        else {
            if !userWonHand {
                userScore += 1
            } else {
                appScore += 1
            }
        }
        
        //
        if currentRound < numberOfRounds {
            currentRound += 1
            prepareNewRound()
        } else {
            gameOver = true
        }
    }
    
    func didUserWinThisHand(userMove: String, appMove: String) -> Bool {
        if userMove == appMove { return false } // Beraberlik
        
        let winningMoves: [String: String] = [
            "Rock": "Scissors",
            "Paper": "Rock",
            "Scissors": "Paper"
        ]
        
        return winningMoves[userMove] == appMove
    }
    
    
    func prepareNewRound() {
        shouldWin = Bool.random()
        
        appMove = choices.randomElement() ?? "Rock"
    }
    
    func restartGame() {
        userScore = 0
        appScore = 0
        currentRound = 1
        gameOver = false
        appMove = choices.randomElement() ?? "Rock"
        shouldWin = Bool.random()
    }
    
    // Oyun sonunda sonucu belirler
    func whoWins() -> String {
        if userScore > appScore {
            return "You won the game!"
        } else if appScore > userScore {
            return "The App won the game!"
        } else {
            return "The game is a tie!"
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
