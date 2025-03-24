//
//  GameOverView.swift
//  WordScramble
//
//  Created by Lilly on 22.03.25.
//

import SwiftUI

struct GameOverView: View {
    
    @Binding var path: NavigationPath
    @EnvironmentObject var config: GameConfiguration
    
    var body: some View {
        VStack {
            GameStatsItem(titleText: "Total Score", valueText: "\(config.totalScore)")
            GameStatsItem(titleText: "Rounds played", valueText: "\(config.numberOfRounds)")
            GameStatsItem(titleText: "Your best word", valueText: "\(config.bestWord)")
            Spacer()
            Button("New Game") {
                path.removeLast(path.count)
            }
            .buttonStyle(FilledButtonStyle(color: .defaultColor))
            Button("View Scoreboard") {
                path.removeLast(path.count)
                path.append("ScoreBoardView")
            }
            .buttonStyle(FilledButtonStyle(color: .defaultColor))
        }
        .padding(.vertical, 80)
    }
}

struct GameStatsItem: View {
    let titleText: String
    let valueText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.title)
                .fontWeight(.bold)
            Text(valueText)
                .font(.title)
        }
        .padding(.bottom, 20)
       
    }
}

#Preview {
    GameOverView(path: .constant(NavigationPath()))
}
