//
//  PlayedWordsView.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import SwiftUI

struct ScoreBoardView: View {
    @StateObject var history = History()
    
    @State private var difficlutySelection: Difficulty = .easy
    @State private var expandedDifficulties = Set<Difficulty>()
    @State private var expandedGameSessions = Set<UUID>()
    @State private var expandedRounds = Set<UUID>()
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack {
            if history.gameSessions.isEmpty {
                Text("No game sessions yet")
                    .font(.headline)
                    .padding()
            } else {
                VStack {
                    Text("Scoreboard")
                        .font(.title)
                        .fontWeight(.bold)
                    Picker("Difficulty", selection: $difficlutySelection) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .tint(.defaultColor)
                    List {
                        let sessions = sortGameSessions(sessions: history.gameSessions.filter { $0.difficulty == difficlutySelection })
                        ForEach(sessions) { session in
                            DisclosureGroup(isExpanded: Binding(
                                get: { expandedGameSessions.contains(session.id) },
                                set: { isExpanded in
                                    if isExpanded {
                                        expandedGameSessions.insert(session.id)
                                    } else {
                                        expandedGameSessions.remove(session.id)
                                    }
                                }
                            )) {
                                ForEach(session.rounds) { round in
                                    DisclosureGroup(isExpanded: Binding(
                                        get: { expandedRounds.contains(round.id) },
                                        set: { isExpanded in
                                            if isExpanded {
                                                expandedRounds.insert(round.id)
                                            } else {
                                                expandedRounds.remove(round.id)
                                            }
                                        }
                                    )) {
                                        ForEach(round.playedWords, id: \.self) { word in
                                            HStack {
                                                Text(word)
                                                Spacer()
                                                Text("\(word.count) letters")
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Text("Word: \(round.rootword)")
                                            Spacer()
                                            Text("Score: \(round.score)")
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("Total Score \(session.totalScore)")
                                        .fontWeight(.bold)
                                        .foregroundColor(.defaultColor)
                                    Spacer()
                                    Text("\(session.date.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
            
            Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Label("Delete History", systemImage: "trash")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.white)
                    .padding()
            }
            .alert("Are you sure?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    history.deleteSavedData()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will erase all your game history.")
            }
        }
        
    }
    
    func difficultyLabel(for difficulty: Difficulty) -> String {
        switch difficulty {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    func sortGameSessions(sessions: [GameSession]) -> [GameSession] {
        sessions.sorted { $0.totalScore > $1.totalScore }
    }
}

