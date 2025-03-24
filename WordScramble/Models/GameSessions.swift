//
//  GameSessions.swift
//  WordScramble
//
//  Created by Lilly on 23.03.25.
//

import Foundation

struct GameSession: Codable, Identifiable {
    var id = UUID()
    let difficulty: Difficulty
    let totalScore: Int
    let rounds: [PlayedRound]
    let date: Date
}
