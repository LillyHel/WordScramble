//
//  PlayedWord.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import Foundation

struct PlayedRound: Codable, Identifiable {
    var id = UUID()
    let rootword: String
    let playedWords: [String]
    let score: Int
}



