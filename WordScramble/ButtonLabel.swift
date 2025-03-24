//
//  ButtonLabel.swift
//  WordScramble
//
//  Created by Lilly on 21.03.25.
//

import SwiftUI

struct ButtonLabel: View {
    let label: String
    var iconSystemName: String?
    var color: Color?
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            if((iconSystemName) != nil) {
                Image(systemName: iconSystemName ?? "questionmark")
            }
        }
        .padding()
        
        
    }
}

#Preview {
    ButtonLabel(label: "Label / Icon / Color", iconSystemName: "globe", color: .yellow)
    ButtonLabel(label: "Label / Color", color: .blue)
    ButtonLabel(label: "Label")
}
