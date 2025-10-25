//
//  SignInView.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/7/25.
//

import SwiftUI

struct SignInView: View {
    // MARK: - Properties
    
    @StateObject private var viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
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
        VStack(spacing: AppSize.spacing(.medium)) {
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
            Group{
                Text(.signInTittle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(.signInSubtitle)
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
        .padding(.bottom, AppSize.defaultPadding)
        .padding(.top, AppSize.defaultPadding)
    }
    
    private var authButtonsSection: some View {
        VStack(spacing: AppSize.spacing(.medium)) {
            ForEach(AuthProvider.allCases, id: \.self) { provider in
                AuthButton(
                    action: {  },
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
                isAnimating: viewModel.isRadarPulseAnimating,
                size: min(geometry.size.width, geometry.size.height)
            )
        }
    }
    
    private var logoAnimation: some View {
        LogoView(isPulsing: viewModel.isLogoPulseAnimating)
    }
    
    // MARK: - Actions
    private func startAnimations() {
        viewModel.isRadarPulseAnimating = true
        viewModel.isLogoPulseAnimating = true
    }
}

// MARK: - Previews
#Preview {
    SignInView(viewModel: SignInViewModel(signInUseCase: AuthUseCaseStrategy()))
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



