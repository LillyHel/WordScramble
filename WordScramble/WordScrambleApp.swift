//
//  WordScrambleApp.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import SwiftUI

@main
struct WordScrambleApp: App {
    @StateObject private var config = GameConfiguration()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(config)
        }
    }
}
