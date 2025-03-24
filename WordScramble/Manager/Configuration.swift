//
//  Configuration.swift
//  WordScramble
//
//  Created by Lilly on 21.03.25.
//

import Foundation

class GameConfiguration: ObservableObject {
    
    @Published var difficulty: Difficulty
    @Published var numberOfRounds: Int
    @Published var totalScore: Int
    @Published var bestWord: String
    
    init(difficulty: Difficulty = .easy, numberOfRounds: Int = 10, totalScore: Int = 0, bestWord: String = "" ) {
        self.difficulty = difficulty
        self.numberOfRounds = numberOfRounds
        self.totalScore = totalScore
        self.bestWord = bestWord
    }
    
    func setDifficulty(_ difficulty: Difficulty) {
        self.difficulty = difficulty;
    }
    
    func setNumberOfRounds(_ number: Int) {
        self.numberOfRounds = number
    }
    
    func setTotalScore(_ score: Int) {
        self.totalScore = score
    }
    
    func setBestWord(_ word: String) {
        self.bestWord = word
    }
}


