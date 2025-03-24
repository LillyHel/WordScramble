//
//  LinearTimeProgressView.swift
//  WordScramble
//
//  Created by Lilly on 22.03.25.
//

import SwiftUI

struct LinearTimerProgressView: View {
    // Gesamtdauer des Timers in Sekunden
    var totalTime: TimeInterval = 60
    
    // State-Variablen
    @State private var timeRemaining: TimeInterval
    @State private var timer: Timer? = nil
    @State private var progress: CGFloat = 1.0
    @State private var isRunning = false
    var onTimerOverAction: () -> Void
    
    // Farben und Styling
    let timerColor = Color.defaultColor
    let backgroundColor = Color(.clear)
    
    init(totalTime: TimeInterval = 60, onTimerOverAction: @escaping () -> Void = {}) {
        self.totalTime = totalTime
        self.onTimerOverAction = onTimerOverAction
        self._timeRemaining = State(initialValue: totalTime)
    }
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                // ProgressBar
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: timerColor))
                    .frame(height: 15)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .animation(.easeInOut(duration: 0.2), value: progress)
                
                // Zeit-Anzeige
                Text("\(Int(timeRemaining))s")
                    .font(.headline)
                    .foregroundColor(.defaultColor)
            }

        }
        .padding()
        .onAppear {
            startTimer()
            }
        .onDisappear {
            stopTimer()
        }
    }
    
    // Timer starten
    func startTimer() {
        stopTimer()
        
        timeRemaining = totalTime
        progress = 1.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                progress = CGFloat(timeRemaining) / CGFloat(totalTime)
            } else {
                stopTimer()
                onTimerOverAction()
                startTimer()
            }
        }
    }
    
    // Timer anhalten
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func nextRound() {
        stopTimer()
        onTimerOverAction()
        
    }
}

#Preview {
    func timerOver() {
        print("Timer over!")
    }
    
    return LinearTimerProgressView(totalTime: 60, onTimerOverAction: timerOver)
}
