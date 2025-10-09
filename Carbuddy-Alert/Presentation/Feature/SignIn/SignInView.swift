//
//  SignInView.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/7/25.
//

import SwiftUI

struct SignInView: View {
    // MARK: - Properties
    @State private var isRadarPulseAnimating = false
    @State private var isLogoPulseAnimating = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        .onAppear(perform: startAnimations)
    }
    
    // MARK: - Views
    private var backgroundView: some View {
        
        LinearGradient(
            colors: [.background1, .background2],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea(.all)
    }
    
    private var contentView: some View {
        VStack(alignment: .center, spacing: AppSize.spacing(.medium)) {
            animatedLogoContainer
            titleSection
            authButtonsSection
        }
        .padding(AppSize.spacing(.high))
    }
    
    private var animatedLogoContainer: some View {
        GlassEffectContainer {
            radarIcon
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: AppSize.spacing(.medium)) {
<<<<<<< HEAD
            Group{
                Text(.signInTittle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(.signInSubtitle)
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            .foregroundStyle(.secondaryText)
        }
        .padding(.bottom, AppSize.defaultPadding)
        .padding(.top, AppSize.defaultPadding)
=======
            Text(.signInTittle)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(.signInSubtitle)
                .font(.title2)
                .fontWeight(.heavy)
        }
        .padding(.bottom, AppSize.defaultPadding)
>>>>>>> 08be4c5acf4a6f3d914753946030ae63243c6d21
    }
    
    private var authButtonsSection: some View {
        VStack(spacing: AppSize.spacing(.medium)) {
            ForEach(AuthProvider.allCases, id: \.self) { provider in
                AuthButton(
                    action: { handleAuth(for: provider) },
                    provider: provider
                )
            }
        }
    }
    
    private var radarIcon: some View {
        ZStack {
            radarAnimation
            logoAnimation
        }
        .frame(
            width: 150,
            height: 150
        )
        .glassEffect(
            .clear.tint(.white.opacity(0.3)).interactive(),
            in: .rect(cornerRadius: AppSize.cornerRadius(.high))
        )
    }
    
    private var radarAnimation: some View {
        GeometryReader { geometry in
            RadarWaveAnimation(
                isAnimating: isRadarPulseAnimating,
                size: min(geometry.size.width, geometry.size.height)
            )
        }
    }
    
    private var logoAnimation: some View {
        LogoView(isPulsing: isLogoPulseAnimating)
    }
    
    // MARK: - Actions
    private func startAnimations() {
        isRadarPulseAnimating = true
        isLogoPulseAnimating = true
    }
    
    private func handleAuth(for provider: AuthProvider) {
        // Aquí iría la lógica de autenticación
        // Podría ser un ViewModel o un Coordinator
        print("Authenticating with \(provider.title)")
    }
}

// MARK: - Subviews
private struct RadarWaveAnimation: View {
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

private struct LogoView: View {
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

// MARK: - Previews
#Preview {
    SignInView()
}
//    ZStack {
//        Color.blue
//            .edgesIgnoringSafeArea(.all)
//        GlassEffectContainer(spacing: 30.0) {
//            // 2.
//            HStack {
//                // 3.
//                Image(systemName: "sun.max.fill")
//                .padding()
//                // 4.
//                .glassEffect()
//
//                Image(systemName: "moon.stars.fill")
//                .padding()
//                .glassEffect()
//
//                Image(systemName: "cloud.rain.fill")
//                .padding()
//                .glassEffect()
//            }
//        }
//    }



