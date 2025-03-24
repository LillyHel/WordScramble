//
//  ContentView.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var config: GameConfiguration
    @StateObject var history = History()
    
    @Binding var path: NavigationPath
    
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords = [String]()
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var countingError = false
    @State private var errorCount = 0
    
    @State private var score = 0
    @State private var roundCount = 1
    @State private var totalScore = 0
    @State private var rounds: [PlayedRound] = []
    
    @State private var bestWord = ""
    @State private var bestScore = 0
    
    var body: some View {
        VStack {
            
            Text("Score: \(score)")
                .font(.title2)
            
            HStack {
                Text("Round \(roundCount) of 5")
                    .font(.subheadline)
                if(config.difficulty == Difficulty.hard) {
                    Text("Errors \(errorCount) of 5")
                        .font(.subheadline)
                        .fontWeight(errorCount == 5 ? .bold : .regular)
                        .foregroundColor(errorCount == 5 ? .red : .white)
                }
            }
            .padding()
            
            
            if config.difficulty.isTimed {
                LinearTimerProgressView(totalTime: 30) {
                    nextRoundOrGameOver()
                }
            }
            
            
            Text(rootWord)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.defaultColor)
                .multilineTextAlignment(.center)
            
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .tint(Color.gray)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            
            Button("Next") {
                nextRoundOrGameOver()
            }
            .buttonStyle(FilledButtonStyle(color: .defaultColor))
            
        }
        .preferredColorScheme(.dark)
        .navigationTitle("Wordscramble")
        .navigationBarTitleDisplayMode(.inline)
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginalWord(answer) else {
            wordError(title: "Unoriginal", message: "You already got that one!")
            countError()
            return
        }
        
        guard isReal(answer) else {
            wordError(title: "Not real", message: "That's not a real word!")
            countError()
            return
        }
        
        guard isPossible(answer) else {
            wordError(title: "Impossible", message: "The word has to consist of letters from \(rootWord).")
            countError()
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += answer.count
        newWord = ""
    }
    
    func nextRoundOrGameOver() {
        rounds.append(PlayedRound(rootword: rootWord, playedWords: usedWords, score: score))
        usedWords = []
        totalScore += score
        
        checkIfBestWord(word: rootWord)
        
        if roundCount >= 5 {
            config.setTotalScore(totalScore)
            config.setNumberOfRounds(roundCount)
            config.setBestWord(bestWord)
            history.addGameSession(
                difficulty: config.difficulty,
                rounds: rounds,
                totalScore: totalScore
            )
            path.append("GameOverView")
        } else {
            roundCount += 1
            startGame()
        }
    }
    
    func isOriginalWord(_ word: String) -> Bool {
        !usedWords.contains(word) && word != rootWord
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func countError() {
        if (config.difficulty == Difficulty.hard) {
            if (errorCount < 5) {
                errorCount += 1
            } else {
                config.setTotalScore(totalScore)
                config.setNumberOfRounds(roundCount)
                config.setBestWord(bestWord)
                history.addGameSession(
                    difficulty: config.difficulty,
                    rounds: rounds,
                    totalScore: totalScore
                )
                path.append("GameOverView")
            }
            
        }
    }
    
    func checkIfBestWord(word: String) {
        if(score > bestScore) {
            bestScore = score
            bestWord = word
        }
    }
}


#Preview {
    let config = GameConfiguration() // oder ein Mock, je nachdem
    ContentView(path: .constant(NavigationPath()))
        .environmentObject(config)
}
