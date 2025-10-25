//
//  LogoView.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/19/25.
//

import SwiftUI

struct LogoView: View {
    let isPulsing: Bool
    
    var body: some View {
        ZStack {
            Text("🐾")
                .font(.system(size: 60))
            
            Group {
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 50)
                Text("📍")
            }
            .font(.system(size: 30))
            .offset(x: 25, y: -30)
            .scaleEffect(isPulsing ? 1.2 : 1.0)
            .animation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true),
                value: isPulsing
            )
        }
    }
}
