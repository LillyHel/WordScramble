//
//  RootView.swift
//  WordScramble
//
//  Created by Lilly on 22.03.25.
//

import SwiftUI

struct RootView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var config: GameConfiguration

    var body: some View {
        NavigationStack(path: $path) {
            StartView(path: $path)
                .navigationDestination(for: String.self) { destination in
                    switch destination {
                    case "ContentView":
                        ContentView(path: $path)
                            .environmentObject(config)
                    case "GameOverView":
                        GameOverView(path: $path)
                            .environmentObject(config)
                    case "ScoreBoardView":
                        ScoreBoardView()
                    default:
                        EmptyView()
                    }
                }
        }
    }
}


#Preview {
    RootView()
}
