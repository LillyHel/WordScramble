//
//  RulesView.swift
//  WordScramble
//
//  Created by Lilly on 23.03.25.
//

import SwiftUI

import SwiftUI

struct RulesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("How to play")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading, spacing: 16) {
                RuleItem(text: "Find words you can create with the letters in the given word.")
                RuleItem(text: "The word has to be at least three letters.")
                RuleItem(text: "The word has to be a legitimate English word.")
                RuleItem(text: "You cannot use the same word twice.")
                RuleItem(text: "Your word cannot be the same as the given word.")
                Spacer()
                Divider()
                    .foregroundColor(.white)
                Spacer()
                RuleItem(text: "Once you believe that you cannot find any more words, press the 'Next' button.", iconName: "arrow.right.circle.fill")
                RuleItem(text: "You can view the words you have played in your scoreboard.", iconName: "list.bullet.circle.fill")
            }
            .padding(.horizontal, 30)
            
            Spacer()

            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding()
    }
}

struct RuleItem: View {
    let text: String
    var iconName: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName ?? "checkmark.circle.fill")
                .foregroundColor(.defaultColor)
                .font(.title3)
            
            Text(text)
                .font(.body)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    RulesView()
}
