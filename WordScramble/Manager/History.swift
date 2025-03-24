//
//  History.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import Foundation

class History: ObservableObject {
    @Published var gameSessions: [GameSession]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedGameSessions")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            gameSessions = try JSONDecoder().decode([GameSession].self, from: data)
            print("Geladene Sessions: \(gameSessions.count)")
        } catch {
            gameSessions = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(gameSessions)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Sessions gespeichert.")
        } catch {
            print("Fehler beim Speichern: \(error)")
        }
    }
    
    func addGameSession(difficulty: Difficulty, rounds: [PlayedRound], totalScore: Int) {
        let session = GameSession(difficulty: difficulty, totalScore: totalScore, rounds: rounds, date: Date())
        gameSessions.insert(session, at: 0)
        save()
        printSavedData()
    }
    
    func printSavedData() {
        do {
            let data = try Data(contentsOf: savePath)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Gespeicherte JSON-Daten: \(jsonString)")
            }
        } catch {
            print("Fehler beim Lesen der Datei: \(error)")
        }
    }
    
    func deleteSavedData() {
        let fileManager = FileManager.default
        do {
            if fileManager.fileExists(atPath: savePath.path) {
                try fileManager.removeItem(at: savePath)
                gameSessions = []
                print("Alle Daten gelöscht.")
            }
        } catch {
            print("Fehler beim Löschen der Datei: \(error)")
        }
    }
}

