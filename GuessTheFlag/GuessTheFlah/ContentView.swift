// GuessTheFlag
import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "russia","poland", "spain", "uk", "us","monaco"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var selectedFlag = 0
    @State private var isGameOver = false
    @State private var numberOfQuestions = 8
    @State private var presentQuestionNumber = 0
    
    @State private var userScore = 0

    
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
                                .aspectRatio(contentMode: .fit)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Question: \(presentQuestionNumber)/\(numberOfQuestions)")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
            .padding()

        }
        // ✅ Cevap alert'i
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Wrong" {
                Text("Wrong! That's the flag of \(countries[selectedFlag].capitalized)")
            }
            Text("Your score is \(userScore)")
        }
        // ✅ Oyun bitti alert'i
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(userScore)/\(numberOfQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        presentQuestionNumber += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
        }
        
        // ✅ Oyun bitti mi kontrol et
        if presentQuestionNumber == numberOfQuestions {
            isGameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // ✅ Yeni restart fonksiyonu
    func restartGame() {
        presentQuestionNumber = 0
        userScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
