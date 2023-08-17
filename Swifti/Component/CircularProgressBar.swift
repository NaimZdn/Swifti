//
//  CircularProgressBar.swift
//  Swifti
//
//  Created by Zidouni on 15/08/2023.
//

import SwiftUI

struct CircularProgressBar: View {
    @Binding var progress: Float
    var score: Int
    var numberOfquestions: Int
    var iconFontSize: CGFloat
    var counterFont: Font
    var firstLineWidth: Double
    var secondLineWidth: Double
    
    init(progress: Binding<Float>, score: Int, numberOfquestions: Int, iconFontSize: CGFloat = 15, counterFont: Font = .courseLabelCounter, firstLineWidth: Double = 7, secondLineWidth: Double = 4.5) {
        _progress = progress
        self.score = score
        self.numberOfquestions = numberOfquestions
        self.iconFontSize = iconFontSize
        self.counterFont = counterFont
        self.firstLineWidth = firstLineWidth
        self.secondLineWidth = secondLineWidth
    }
    
    @State private var animatingProgress: Float = 0.0
    
    private func animateProgress() {
        withAnimation(.easeInOut(duration: 1.0)) {
            animatingProgress = progress
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: firstLineWidth)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Text(score == numberOfquestions ? "🏅" : "\(score)/\(numberOfquestions)")
                .font(score == numberOfquestions ? .system(size: iconFontSize) : counterFont)
                .foregroundColor(.white)
            
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(animatingProgress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: secondLineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(score == numberOfquestions ? .green : .primaryColor)
                .rotationEffect(Angle(degrees: 270))
                .onAppear {
                    animateProgress()
                }
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(progress: .constant(1), score: 10, numberOfquestions: 10)
            .frame(width: 40, height: 40)
    }
}
