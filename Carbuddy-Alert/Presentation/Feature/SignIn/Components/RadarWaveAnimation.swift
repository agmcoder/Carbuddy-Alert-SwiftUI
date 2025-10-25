//
//  RadarWaveAnimation.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/19/25.
//

import SwiftUI

struct RadarWaveAnimation: View {
    let isAnimating: Bool
    let size: CGFloat
    
    private var baseDiameter: CGFloat { size * 0.2 }
    private var maxScale: CGFloat { size / baseDiameter }
    
    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .stroke(.white.opacity(0.6), lineWidth: 3)
                    .frame(width: baseDiameter, height: baseDiameter)
                    .scaleEffect(isAnimating ? maxScale : 1.0)
                    .opacity(isAnimating ? 0.0 : 1.0)
                    .animation(
                        .easeOut(duration: 3)
                        .repeatForever(autoreverses: false)
                        .delay(Double(index) * 1.0),
                        value: isAnimating
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
