//
//  StartView.swift
//  WordScramble
//
//  Created by Lilly on 21.03.25.
//

import SwiftUI

struct StartView: View {
    @StateObject var history = History()
    @State private var selection = Difficulty.easy
    @EnvironmentObject var config: GameConfiguration
    
    @Binding var path: NavigationPath
    
    @State private var showingHistory = false
    @State private var showRulesSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Objective".uppercased())
                .font(.caption)
                .padding(.bottom, 5)
            VStack(alignment: .leading) {
    
                Text("Make new words from a random eight-letter word!")
                    .font(.title2)
            }
            Spacer()
            Text("Difficutly".uppercased())
                .font(.caption)
                .padding(.bottom, 5)
            VStack {
                ForEach(Difficulty.allCases) { difficulty in
                    VStack {
                        Text(difficulty.rawValue.capitalized).tag(difficulty)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.defaultColor)
                            .padding(.bottom, 10)
                        
                        
                        Text(difficulty.description)
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selection == difficulty  ? .defaultColor : .clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selection = difficulty
                        config.setDifficulty(difficulty)
                    }
                    
                }
            }
            
            Spacer()
            
            HStack {
                Spacer() // Schiebt den Button nach rechts
                Button("Start Game") {
                    path.append("ContentView")
                }
                .buttonStyle(FilledButtonStyle(color: .defaultColor))
                Spacer() // Schiebt den Button nach links
            }

        }
        .padding()
        .navigationTitle("WordScramble")
        .preferredColorScheme(.dark)
        .toolbar {
            HStack(spacing: 15) {
                Button {
                    showRulesSheet = true
                } label: {
                    Image(systemName: "questionmark")
                        .foregroundColor(.white)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .stroke(.white)
                        )
                }
                Button{
                    showingHistory = true
                } label: {
                    Image(systemName: "list.star")
                        .foregroundColor(.white)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .stroke(.white)
                        )

                }
                
            }
            
        }
        .sheet(isPresented: $showingHistory, content: ScoreBoardView.init)
        .sheet(isPresented: $showRulesSheet) {
            RulesView()
        }
    }
    
    
    
}

#Preview {
    StartView(path: .constant(NavigationPath()))
}
