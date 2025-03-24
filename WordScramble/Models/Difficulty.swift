//
//  Difficulty.swift
//  WordScramble
//
//  Created by Lilly on 23.03.25.
//

import Foundation

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy, medium, hard
    
    var id: String { self.rawValue }
    
    var isTimed: Bool {
        switch self {
        case .easy: return false
        case .medium, .hard: return true
        }
    }
    
    var description: String {
        switch self {
        case .easy: return "Take your time finding all the words. No wrong guesses!"
        case .medium: return "You are on the clock! Find as many words as possible in 30s"
        case .hard: return "Think fast! But choose your words carefully. If you get it wrong more than 5 times, you're out."
        }
    }
}
