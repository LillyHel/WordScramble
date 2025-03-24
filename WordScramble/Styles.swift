//
//  Styles.swift
//  WordScramble
//
//  Created by Lilly on 21.03.25.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var defaultColor: Color {
        Color(red: 0.145, green: 0.8, blue: 0.623)
    }
}

struct FilledButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(height: 40)
            .background(color)
            .foregroundStyle(.black)
            .clipShape(Capsule())
    }
}
